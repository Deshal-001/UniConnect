package com.uniconnect.backend.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Builder
@Table(name = "event")

@NoArgsConstructor
@AllArgsConstructor
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Long id;

    @Column(nullable = false)
    private String title;

    private String description;

    @Column(nullable = false)
    private LocalDateTime date;

    @Column(nullable = false)
    private int maxParticipants;

    @Column(nullable = false)
    private String location;

    @Column(nullable = true)
    private String imgUrl;

    @ManyToOne
    @JoinColumn(name = "creator_id", nullable = false)
    private User creator;

    @ManyToOne
    @JoinColumn(name = "university_id")
    private University university;

    @Column(nullable = false)
    private boolean restrictToUniversity;

    // We can use this method without creating a separate table for bookings
//    @ManyToMany
//    @JoinTable(
//            name = "event_attendees",
//            joinColumns = @JoinColumn(name = "event_id"),
//            inverseJoinColumns = @JoinColumn(name = "user_id")
//    )
//    private Set<User> attendees = new HashSet<>();
    // Tracks users who booked

}