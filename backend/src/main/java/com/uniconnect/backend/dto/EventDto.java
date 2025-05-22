package com.uniconnect.backend.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventDto {  // Add 'public' here
    private Long id;

    @NotBlank(message = "Title is required")
    private String title;

    private String description;

    @NotNull(message = "Date is required")
    private LocalDateTime date;

    @Min(value = 1, message = "Max participants must be at least 1")
    private int maxParticipants;

    private int currentAttendees; // Number of booked users

    private String location;

    private String imgUrl;

    private Long creatorId;

    private Long universityId;

    private String universityName;

    private boolean restrictToUniversity;


}
