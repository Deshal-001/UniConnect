package com.uniconnect.backend.repository;

import com.uniconnect.backend.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByDateAfterOrderByDateAsc(LocalDateTime date);
    List<Event> findByLocationContainingIgnoreCase(String location);
}