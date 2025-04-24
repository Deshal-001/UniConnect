package com.uniconnect.backend.dto;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CommonErrorResponse {
    private int errorCode;
    private String message;
}
