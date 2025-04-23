package com.uniconnect.backend.controller;

import com.uniconnect.backend.dto.EventDto;
import com.uniconnect.backend.dto.UserDto;
import com.uniconnect.backend.model.University;
import com.uniconnect.backend.service.EventService;
import com.uniconnect.backend.repository.UniversityRepository;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class EventController {
    private final EventService eventService;
    private final UniversityRepository universityRepository;

    public EventController(EventService eventService, UniversityRepository universityRepository) {
        this.eventService = eventService;
        this.universityRepository = universityRepository;
    }

    @PostMapping("/event")
    public ResponseEntity<EventDto> createEvent(@Valid @RequestBody EventDto eventDto) {
        return ResponseEntity.ok(eventService.createEvent(eventDto));
    }

    @PostMapping("/event/{id}/book")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<EventDto> bookEvent(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.bookEvent(id));
    }

    @DeleteMapping("/event/{id}/book")
    @PreAuthorize("hasRole('USER')")
    public ResponseEntity<EventDto> cancelBooking(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.cancelBooking(id));
    }

    @GetMapping("/event/upcoming")
    public ResponseEntity<List<EventDto>> getUpcomingEvents() {
        return ResponseEntity.ok(eventService.getUpcomingEvents());
    }

    @GetMapping("/event/{id}")
    public ResponseEntity<EventDto> getEvent(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getEvent(id));
    }

    @GetMapping("/event/all")
    public ResponseEntity<List<EventDto>> getAllEvents() {
        return ResponseEntity.ok(eventService.getAllEvents());
    }

    @DeleteMapping("/event/{id}")
    @PreAuthorize("hasRole('ADMIN') or @securityService.isEventCreator(#id, authentication)")
    public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/event/{id}/attendees")
    @PreAuthorize("hasRole('ADMIN') or @securityService.isEventCreator(#id, authentication)")
    public ResponseEntity<List<UserDto>> getEventAttendees(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getEventAttendees(id));
    }

    @GetMapping("/universities")
    public ResponseEntity<List<University>> getAllUniversities() {
        return ResponseEntity.ok(universityRepository.findAll());
    }
}