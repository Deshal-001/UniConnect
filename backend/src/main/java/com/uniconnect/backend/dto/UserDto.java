package com.uniconnect.backend.dto;

import com.uniconnect.backend.model.Role;
import com.uniconnect.backend.model.University;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor(force = true)
@AllArgsConstructor
public class UserDto {
    private Long id;
    private String email;
    private String fullName;
    private Role role;
    private University university;
}
