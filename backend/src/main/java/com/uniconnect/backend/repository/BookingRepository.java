package com.uniconnect.backend.repository;

import com.uniconnect.backend.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    // Check if a user has booked an event
    boolean existsByEventIdAndUserId(Long eventId, Long userId);

    // Count bookings for an event
    long countByEventId(Long eventId);

    // Find a booking by event and user
    Optional<Booking> findByEventIdAndUserId(Long eventId, Long userId);

    List<Booking> findByEventId(Long eventId);
}