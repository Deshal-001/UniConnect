package com.uniconnect.backend.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class RegisterRequest {
    private String email;
    private String password;
    private String fullName;
    private String location;
    private LocalDateTime birthday;
}
