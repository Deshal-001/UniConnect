package com.uniconnect.backend.service;

import com.uniconnect.backend.dto.EventDto;
import com.uniconnect.backend.dto.UserDto;
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
            throw new RuntimeException("Event date cannot be in the past");
        }
        if (eventDto.getMaxParticipants() < 1) {
            throw new RuntimeException("Max participants must be at least 1");
        }
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User creator = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User doesn't exist"));

        University university = null;
        if (eventDto.getUniversityId() != null) {
            university = universityRepository.findById(eventDto.getUniversityId())
                    .orElseThrow(() -> new RuntimeException("University not found"));
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
                .build();
        event = eventRepository.save(event);
        return mapToDto(event);
    }

    @Transactional
    public EventDto bookEvent(Long eventId) {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User doesn't exist"));
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Event not found"));

        // Check university restriction
        if (event.isRestrictToUniversity() && event.getUniversity() != null) {
            if (user.getUniversity() == null || !user.getUniversity().getId().equals(event.getUniversity().getId())) {
                throw new RuntimeException("Only members of the organizing university can book this event");
            }
        }

        // Check if already booked
        if (bookingRepository.existsByEventIdAndUserId(eventId, user.getId())) {
            throw new RuntimeException("You have already booked this event");
        }

        // Check max participants
        long currentBookings = bookingRepository.countByEventId(eventId);
        if (currentBookings >= event.getMaxParticipants()) {
            throw new RuntimeException("Event is fully booked");
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
                .orElseThrow(() -> new RuntimeException("User doesn't exist"));
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Event not found"));

        Booking booking = bookingRepository.findByEventIdAndUserId(eventId, user.getId())
                .orElseThrow(() -> new RuntimeException("You are not booked for this event"));

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
                .orElseThrow(() -> new RuntimeException("Event not found"));
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
                .orElseThrow(() -> new RuntimeException("Event not found"));
        bookingRepository.deleteAll(bookingRepository.findByEventId(id));
    }

    public List<UserDto> getEventAttendees(Long eventId) {
        Event event = eventRepository.findById(eventId)
                .orElseThrow(() -> new RuntimeException("Event not found"));
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
        dto.setCurrentAttendees((int) bookingRepository.countByEventId(event.getId()));
        if (event.getUniversity() != null) {
            dto.setUniversityId(event.getUniversity().getId());
            dto.setUniversityName(event.getUniversity().getName());
        }
        dto.setRestrictToUniversity(event.isRestrictToUniversity());
        return dto;
    }
}