package com.uniconnect.backend.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@Entity
@Builder
@Table(name = "UsersTable")
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
@GeneratedValue
private Long id;

    private String email;

    private String password;

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false)
    private String location;

    @Column(nullable = false)
    private LocalDateTime birthday;

    @Enumerated(EnumType.STRING)
    private Role role;

    @ManyToOne
    @JoinColumn(name = "university_id")
    private University university;



}

