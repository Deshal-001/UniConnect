package com.uniconnect.backend.controller;

import com.uniconnect.backend.dto.EventDto;
import com.uniconnect.backend.service.EventService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("api/event")
public class EventController {
    private final EventService eventService;

    public EventController(EventService eventService) {
        this.eventService = eventService;
    }

    /**
     * Creates a new event.
     * Requires a valid EventDto in the request body.
     * @param eventDto the event data
     * @return the created event details
     */
    @PostMapping
    public ResponseEntity<EventDto> createEvent(@Valid @RequestBody EventDto eventDto) {
        return ResponseEntity.ok(eventService.createEvent(eventDto));
    }

    /**
     * Retrieves a list of upcoming events (date after now), sorted by date.
     * @return list of upcoming events
     */
    @GetMapping
    public ResponseEntity<List<EventDto>> getUpcomingEvents() {
        return ResponseEntity.ok(eventService.getUpcomingEvents());
    }

    /**
     * Retrieves details of a specific event by its ID.
     * @param id the ID of the event
     * @return event details
     */
    @GetMapping("/{id}")
    public ResponseEntity<EventDto> getEvent(@PathVariable Long id) {
        return ResponseEntity.ok(eventService.getEvent(id));
    }

    /**
     * Deletes an event by its ID.
     * Access restricted to users with ADMIN role.
     * @param id the ID of the event to delete
     * @return 204 No Content on successful deletion
     */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return ResponseEntity.noContent().build();
    }
}
