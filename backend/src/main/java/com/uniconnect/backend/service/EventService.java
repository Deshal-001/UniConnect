package com.uniconnect.backend.service;


import com.uniconnect.backend.dto.EventDto;
import com.uniconnect.backend.model.Event;
import com.uniconnect.backend.model.User;
import com.uniconnect.backend.repository.EventRepository;
import com.uniconnect.backend.repository.UserRepository;
import com.uniconnect.backend.security.SecurityConfig;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class EventService {
    private final EventRepository eventRepository;
    private final UserRepository userRepository;

    public EventService(EventRepository eventRepository , UserRepository userRepository ){
        this.eventRepository = eventRepository;
        this.userRepository = userRepository;
    }

    public EventDto createEvent (EventDto eventDto){
        if (eventDto.getDate().isBefore(LocalDateTime.now())){
            throw new RuntimeException("Event Date Cannot Be Past");
        }
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        User creator = userRepository.findByEmail(email).orElseThrow(()-> new RuntimeException("User Doesn't exist"));
        Event event = Event.builder().title(eventDto.getTitle())
                .description(eventDto.getDescription())
                .date(eventDto.getDate())
                .location(eventDto.getLocation())
                .creator(creator)
                .build();
        event = eventRepository.save(event);
        eventDto.setId(event.getId());
        eventDto.setCreatorId(eventDto.getCreatorId());

        return eventDto;

    }

    public List<EventDto> getUpcomingEvents() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return eventRepository.findByDateAfterOrderByDateAsc(LocalDateTime.now())
                .stream()
                .map(event -> {
                    EventDto dto = new EventDto();
                    dto.setId(event.getId());
                    dto.setTitle(event.getTitle());
                    dto.setDescription(event.getDescription());
                    dto.setDate(event.getDate());
                    dto.setLocation(event.getLocation());
                    dto.setCreatorId(event.getCreator().getId());
                    return dto;
                })
                .collect(Collectors.toList());
    }

    public EventDto getEvent(Long id) {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Event not found"));
        EventDto dto = new EventDto();
        dto.setId(event.getId());
        dto.setTitle(event.getTitle());
        dto.setDescription(event.getDescription());
        dto.setDate(event.getDate());
        dto.setLocation(event.getLocation());
        dto.setCreatorId(event.getCreator().getId());
        return dto;
    }

    public List<EventDto> getAllEvents(){
        return eventRepository.findAll().stream().map(event -> {
            EventDto dto = new EventDto();
            dto.setId(event.getId());
            dto.setTitle(event.getTitle());
            dto.setDescription(event.getDescription());
            dto.setDate(event.getDate());
            dto.setLocation(event.getLocation());
            dto.setCreatorId(event.getCreator().getId());
            return dto;
        }).collect(Collectors.toList());
    }

    public void deleteEvent(Long id) {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Event not found"));
        eventRepository.delete(event);
    }
}
