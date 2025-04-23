package com.uniconnect.backend.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public enum ErrorCodes {
    // Event-related errors
    EVENT_PAST_DATE("2001", "Event date cannot be in the past", HttpStatus.BAD_REQUEST),
    INVALID_MAX_PARTICIPANTS("2002", "Max participants must be at least 1", HttpStatus.BAD_REQUEST),
    USER_NOT_FOUND("2003", "User doesn't exist", HttpStatus.NOT_FOUND),
    UNIVERSITY_NOT_FOUND("2004", "University not found", HttpStatus.NOT_FOUND),
    EVENT_NOT_FOUND("2005", "Event not found", HttpStatus.NOT_FOUND),
    UNIVERSITY_RESTRICTION("2006", "Only members of the organizing university can book this event", HttpStatus.FORBIDDEN),
    ALREADY_BOOKED("2007", "You have already booked this event", HttpStatus.BAD_REQUEST),
    EVENT_FULL("2008", "Event is fully booked", HttpStatus.CONFLICT),
    NOT_BOOKED("2009", "You are not booked for this event", HttpStatus.BAD_REQUEST),
    EVENT_HAS_BOOKINGS("2010", "Cannot delete event with existing bookings", HttpStatus.CONFLICT),
    // Authentication-related errors
    INVALID_PASSWORD("1001", "Invalid password", HttpStatus.UNAUTHORIZED),
    USER_ALREADY_EXISTS("1002", "User already exists", HttpStatus.CONFLICT);


    private final String code;
    private final String message;
    private final HttpStatus status;

    ErrorCodes(String code, String message, HttpStatus status) {
        this.code = code;
        this.message = message;
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public HttpStatus getStatus() {
        return status;
    }
}