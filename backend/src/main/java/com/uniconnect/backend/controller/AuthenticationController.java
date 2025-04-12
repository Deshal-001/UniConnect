package com.uniconnect.backend.controller;

import com.uniconnect.backend.dto.AuthenticationRequest;
import com.uniconnect.backend.dto.AuthenticationResponse;
import com.uniconnect.backend.dto.UsersListResponse;
import com.uniconnect.backend.service.AuthenticationService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    public AuthenticationController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }

    @PostMapping("/login")
    public AuthenticationResponse login(@Valid @RequestBody AuthenticationRequest authRequest) {
        String token = authenticationService.login(authRequest.getEmail(), authRequest.getPassword());
        return  AuthenticationResponse.builder()
                .token(token)
                .build();
    }

    @PostMapping("/register")
    public AuthenticationResponse register(@Valid @RequestBody AuthenticationRequest authRequest) {
        String token = authenticationService.register(authRequest.getEmail(), authRequest.getPassword());
        return AuthenticationResponse.builder().token(token).build();
    }

    @GetMapping("/users")
    public UsersListResponse getAllUsers(){
        var users = authenticationService.getAllUsers();
        return UsersListResponse.builder().userList(users).build();
    }
}