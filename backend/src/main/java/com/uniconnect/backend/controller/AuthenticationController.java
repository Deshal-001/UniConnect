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

    /**
     * Authenticates a user and returns a JWT token.
     * @param authRequest the login credentials (email and password)
     * @return authentication token
     */
    @PostMapping("/login")
    public AuthenticationResponse login(@Valid @RequestBody AuthenticationRequest authRequest) {
        String token = authenticationService.login(authRequest.getEmail(), authRequest.getPassword());
        return AuthenticationResponse.builder()
                .token(token)
                .build();
    }

    /**
     * Registers a new user and returns a JWT token.
     * @param request the registration details
     * @return authentication token
     */
    @PostMapping("/register")
    public AuthenticationResponse register(@Valid @RequestBody RegisterRequest request) {
        String token = authenticationService.register(
                request.getEmail(),
                request.getPassword(),
                request.getFullName(),
                request.getLocation(),
                request.getBirthday()
        );
        return AuthenticationResponse.builder().token(token).build();
    }

    /**
     * Registers a new admin user and returns a JWT token.
     * @param request the admin registration details
     * @return authentication token
     */
    @PostMapping("/registerAdmin")
    public AuthenticationResponse registerAdmin(@Valid @RequestBody RegisterRequest request) {
        String token = authenticationService.registerAdmin(
                request.getEmail(),
                request.getPassword(),
                request.getFullName(),
                request.getLocation(),
                request.getBirthday()
        );
        return AuthenticationResponse.builder().token(token).build();
    }

    /**
     * Deletes a user by email.
     * Access restricted to users with ADMIN role.
     * @param deleteRequest contains the email of the user to be deleted
     * @return success message
     */
    @DeleteMapping("/admin/user")
    @PreAuthorize("hasRole('ADMIN')")
    public DeleteResponse deleteUser(@Valid @RequestBody DeleteRequest deleteRequest) {
        authenticationService.deleteUser(deleteRequest.getEmail());
        return DeleteResponse.builder()
                .message("User deleted successfully")
                .build();
    }

    /**
     * Deletes the authenticated user's own account.
     * @return success message
     */
    @DeleteMapping("/user")
    public DeleteResponse deleteUser() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        authenticationService.deleteUser(email);
        return DeleteResponse.builder()
                .message("User deleted successfully")
                .build();
    }

    /**
     * Retrieves a list of all registered users.
     * @return list of users
     */
    @GetMapping("/users")
    public UsersListResponse getAllUsers() {
        var users = authenticationService.getAllUsers();
        return UsersListResponse.builder().userList(users).build();
    }
}
