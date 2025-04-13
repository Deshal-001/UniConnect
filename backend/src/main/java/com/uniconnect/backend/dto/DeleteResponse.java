package com.uniconnect.backend.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DeleteResponse {
    private String message;
}
