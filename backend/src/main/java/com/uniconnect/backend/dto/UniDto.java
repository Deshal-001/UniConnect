package com.uniconnect.backend.dto;


import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UniDto {
    private Long id;
    private String name;
    private String imgUrl;
    private String location;
}
