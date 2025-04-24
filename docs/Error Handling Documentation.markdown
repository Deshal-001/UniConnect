# Error Handling Documentation

## Overview

The Spring Boot REST API uses a structured error handling mechanism to provide consistent, meaningful error responses for frontend integration and localization. It replaces generic `RuntimeException` instances with `ApiException` and a centralized `ErrorCode` enum, applied in `EventService` and `AuthenticationService`. The `GlobalExceptionHandler` ensures all errors are returned in a standard JSON format with appropriate HTTP status codes.

## Purpose

- Deliver unique error codes and messages for frontend error tracking and localization.
- Ensure maintainability and consistency across services.
- Use appropriate HTTP status codes (`400`, `401`, `404`, `409`) for clear error communication.

## Implementation

### ErrorCode Enum

The `ErrorCode` enum centralizes error codes, messages, and HTTP statuses in `ErrorCode.java`.

**Example**:
```java
public enum ErrorCode {
    EVENT_PAST_DATE("2001", "Event date cannot be in the past", HttpStatus.BAD_REQUEST),
    USER_NOT_FOUND("2003", "User doesn't exist", HttpStatus.NOT_FOUND),
    INVALID_PASSWORD("2011", "Invalid password", HttpStatus.UNAUTHORIZED),
    USER_ALREADY_EXISTS("2012", "User already exists", HttpStatus.CONFLICT);
    // Other fields and methods
}
```

### ApiException

The `ApiException` class encapsulates errors using `ErrorCode` for type-safe handling.

**Example**:
```java
public class ApiException extends RuntimeException {
    private final String errorCode;
    private final HttpStatus status;

    public ApiException(ErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode.getCode();
        this.status = errorCode.getStatus();
    }
}
```

### GlobalExceptionHandler

The `GlobalExceptionHandler` catches `ApiException` instances thrown by services and returns structured JSON responses. It uses `@RestControllerAdvice` to handle errors across all API controllers, ensuring a consistent error format without repetitive code in each service.

**How It Works**:
- When a service (e.g., `EventService`) throws an `ApiException` (e.g., for a past event date), `GlobalExceptionHandler` intercepts it.
- It extracts the `errorCode`, `message`, and `status` from the `ApiException`.
- It creates an `ErrorResponse` object and returns it as JSON with the correct HTTP status.

**Example**:
```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ApiException.class)
    public ResponseEntity<ErrorResponse> handleApiException(ApiException ex) {
        ErrorResponse errorResponse = new ErrorResponse(ex.getErrorCode(), ex.getMessage());
        return new ResponseEntity<>(errorResponse, ex.getStatus());
    }

    static class ErrorResponse {
        private final String errorCode;
        private final String message;
        // Constructor and getters
    }
}
```

**Example Response**:
```json
{
    "errorCode": "2001",
    "message": "Event date cannot be in the past"
}
```

### Services

- **EventService**: Manages events with errors like `EVENT_PAST_DATE`, `EVENT_NOT_FOUND`.
- **AuthenticationService**: Handles authentication with errors like `INVALID_PASSWORD`, `USER_ALREADY_EXISTS`.

## Error Codes

| Code | Description                              | HTTP Status       |
|------|------------------------------------------|-------------------|
| 2001 | Event date cannot be in the past         | 400 Bad Request   |
| 2003 | User doesn't exist                       | 404 Not Found     |
| 2004 | University not found                     | 404 Not Found     |
| 2005 | Event not found                          | 404 Not Found     |
| 2006 | University restriction violation         | 403 Forbidden     |
| 2007 | Already booked event                     | 400 Bad Request   |
| 2008 | Event is fully booked                    | 409 Conflict      |
| 2009 | Not booked for event                     | 400 Bad Request   |
| 2010 | Cannot delete event with bookings        | 409 Conflict      |
| 2011 | Invalid password                         | 401 Unauthorized  |
| 2012 | User already exists                      | 409 Conflict      |

## Maintenance

- Add new errors to the `ErrorCode` enum as needed.
- Ensure frontend maps `errorCode` to localized messages.