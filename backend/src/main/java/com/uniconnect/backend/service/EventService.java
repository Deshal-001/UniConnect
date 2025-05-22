package com.uniconnect.backend.service;

import com.uniconnect.backend.dto.EventDto;
import com.uniconnect.backend.dto.UserDto;
import com.uniconnect.backend.exception.ApiException;
import com.uniconnect.backend.exception.ErrorCodes;
import com.uniconnect.backend.model.Booking;
import com.uniconnect.backend.model.Event;
import com.uniconnect.backend.model.University;
import com.uniconnect.backend.model.User;
import com.uniconnect.backend.repository.BookingRepository;
import com.uniconnect.backend.repository.EventRepository;
import com.uniconnect.backend.repository.UserRepository;
import com.uniconnect.backend.repository.UniversityRepository;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class EventService {
    private final EventRepository eventRepository;
    private final UserRepository userRepository;
    private final BookingRepository bookingRepository;
    private final UniversityRepository universityRepository;

    public EventService(EventRepository eventRepository, UserRepository userRepository,
                        BookingRepository bookingRepository, UniversityRepository universityRepository) {
        this.eventRepository = eventRepository;
        this.userRepository = userRepository;
        this.bookingRepository = bookingRepository;
        this.universityRepository = universityRepository;
    }

    @Transactional
    public EventDto createEvent(EventDto eventDto) {
        if (eventDto.getDate().isBefore(LocalDateTime.now())) {
            throw new ApiException(ErrorCodes.EVENT_PAST_DATE);
        }
        if (eventDto.getMaxParticipants() < 1) {
            throw new ApiException(ErrorCodes.INVALID_MAX_PARTICIPANTS);
        }
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User creator = userRepository.findByEmail(email)
                .orElseThrow(() -> new ApiException(ErrorCodes.USER_NOT_FOUND));

        University university = null;
        if (eventDto.getUniversityId() != null) {
            university = universityRepository.findById(eventDto.getUniversityId())
                    .orElseThrow(() -> new ApiException(ErrorCodes.UNIVERSITY_NOT_FOUND));
        }

        Event event = Event.builder()
                .title(eventDto.getTitle())
                .description(eventDto.getDescription())
                .date(eventDto.getDate())
                .location(eventDto.getLocation())
                .maxParticipants(eventDto.getMaxParticipants())
                .creator(creator)
                .university(university)
                .restrictToUniversity(eventDto.isRestrictToUniversity())
                .imgUrl(eventDto.getImgUrl())
                .build();
        event = eventRepository.save(event);
        return mapToDto(event);
    }

    @Transactional
    public EventDto bookEvent(Long eventId) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ApiException(ErrorCodes.USER_NOT_FOUND));
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new ApiException(ErrorCodes.EVENT_NOT_FOUND));

        // Check university restriction
        if (event.isRestrictToUniversity() && event.getUniversity() != null) {
            if (user.getUniversity() == null || !user.getUniversity().equals(event.getUniversity().getId())) {
                throw new ApiException(ErrorCodes.UNIVERSITY_RESTRICTION);
            }
        }

        // Check if already booked
        if (bookingRepository.existsByEventIdAndUserId(eventId, user.getId())) {
            throw new ApiException(ErrorCodes.ALREADY_BOOKED);
        }

        // Check max participants
        long currentBookings = bookingRepository.countByEventId(eventId);
        if (currentBookings >= event.getMaxParticipants()) {
            throw new ApiException(ErrorCodes.EVENT_FULL);
        }

        // Create booking
        Booking booking = Booking.builder()
                .event(event)
                .user(user)
                .bookedAt(LocalDateTime.now())
                .build();
        bookingRepository.save(booking);

        return mapToDto(event);
    }

    @Transactional
    public EventDto cancelBooking(Long eventId) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ApiException(ErrorCodes.USER_NOT_FOUND));
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new ApiException(ErrorCodes.EVENT_NOT_FOUND));

        Booking booking = bookingRepository.findByEventIdAndUserId(eventId, user.getId())
                .orElseThrow(() -> new ApiException(ErrorCodes.NOT_BOOKED));

        bookingRepository.delete(booking);

        return mapToDto(event);
    }

    public List<EventDto> getUpcomingEvents() {
        return eventRepository.findByDateAfterOrderByDateAsc(LocalDateTime.now())
                .stream()
                .map(this::mapToDto)
                .collect(Collectors.toList());
    }

    public EventDto getEvent(Long id) {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new ApiException(ErrorCodes.EVENT_NOT_FOUND));
        return mapToDto(event);
    }

    public List<EventDto> getAllEvents() {
        return eventRepository.findAll()
                .stream()
                .map(this::mapToDto)
                .collect(Collectors.toList());
    }

    public void deleteEvent(Long id) {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new ApiException(ErrorCodes.EVENT_NOT_FOUND));
        long bookingCount = bookingRepository.countByEventId(id);
        if (bookingCount > 0) {
            throw new ApiException(ErrorCodes.EVENT_HAS_BOOKINGS);
        }
        bookingRepository.deleteAll(bookingRepository.findByEventId(id));
        eventRepository.delete(event);
    }

    public List<UserDto> getEventAttendees(Long eventId) {
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new ApiException(ErrorCodes.EVENT_NOT_FOUND));
        return bookingRepository.findByEventId(eventId)
                .stream()
                .map(booking -> {
                    User user = booking.getUser();
                    return UserDto.builder()
                            .id(user.getId())
                            .email(user.getEmail())
                            .role(user.getRole())
                            .build();
                })
                .collect(Collectors.toList());
    }

    private EventDto mapToDto(Event event) {
        EventDto dto = new EventDto();
        dto.setId(event.getId());
        dto.setTitle(event.getTitle());
        dto.setDescription(event.getDescription());
        dto.setDate(event.getDate());
        dto.setLocation(event.getLocation());
        dto.setMaxParticipants(event.getMaxParticipants());
        dto.setCreatorId(event.getCreator().getId());
        dto.setImgUrl(event.getImgUrl());
        dto.setCurrentAttendees((int) bookingRepository.countByEventId(event.getId()));
        if (event.getUniversity() != null) {
            dto.setUniversityId(event.getUniversity().getId());
            dto.setUniversityName(event.getUniversity().getName());
        }
        dto.setRestrictToUniversity(event.isRestrictToUniversity());
        return dto;
    }
}