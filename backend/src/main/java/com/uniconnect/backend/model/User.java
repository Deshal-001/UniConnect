package com.uniconnect.backend.model;

import jakarta.persistence.*;
import lombok.*;

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
private Integer id;

    private String email;

    private String password;

    @Enumerated(EnumType.STRING)
    private Role role;



}

