package com.uniconnect.backend.dto;


import lombok.Builder;
import lombok.Data;
@Builder

@Data
public class AuthenticationResponse {
    private String token;
}
