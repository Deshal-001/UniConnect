package com.uniconnect.backend.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class ApiException extends RuntimeException {
    private final String errorCode;
    private final HttpStatus status;

    public ApiException(ErrorCodes errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode.getCode();
        this.status = errorCode.getStatus();
    }

}