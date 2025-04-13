package com.uniconnect.backend.controller;

import com.uniconnect.backend.dto.*;
import com.uniconnect.backend.service.AuthenticationService;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
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

    @PostMapping("/registerAdmin")
    public AuthenticationResponse registerAdmin(@Valid @RequestBody AuthenticationRequest request){
        String token = authenticationService.registerAdmin(request.getEmail(),request.getPassword());
        return AuthenticationResponse.builder().token(token).build();
    }

    @DeleteMapping("/admin/user")
    @PreAuthorize("hasRole('ADMIN')")
    public DeleteResponse deleteUser(@Valid @RequestBody DeleteRequest deleteRequest) {
        authenticationService.deleteUser(deleteRequest.getEmail());
        return DeleteResponse.builder()
                .message("User deleted successfully")
                .build();
    }

    @DeleteMapping("/user")
    public DeleteResponse deleteUser() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        authenticationService.deleteUser(email);
        return DeleteResponse.builder()
                .message("User deleted successfully")
                .build();
    }

    @GetMapping("/users")
    public UsersListResponse getAllUsers(){
        var users = authenticationService.getAllUsers();
        return UsersListResponse.builder().userList(users).build();
    }
}