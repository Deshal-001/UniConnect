package com.uniconnect.backend.service;

import com.uniconnect.backend.model.Role;
import com.uniconnect.backend.model.User;
import com.uniconnect.backend.repository.UserRepository;
import com.uniconnect.backend.security.JwtService;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class AuthenticationService {

    private final JwtService jwtService;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public AuthenticationService(
            JwtService jwtService,
            UserRepository userRepository,
            PasswordEncoder passwordEncoder
    ) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // Authenticates user and generates JWT token
    public String login(String email, String password) {
        var user = userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("Invalid password");
        }

        Set<SimpleGrantedAuthority> authorities = Set.of(
                new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
        );

        return jwtService.generateToken(email, authorities);
    }

    // Registers new user with default USER role and generates JWT token
    public String register(String email, String password, String fullName, String location, LocalDateTime birthday) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("User already exists");
        }

        var user = User.builder()
                .email(email)
                .password(passwordEncoder.encode(password))
                .fullName(fullName)
                .location(location)
                .birthday(birthday)
                .role(Role.USER) // Default role
                .build();

        userRepository.save(user);

        Set<SimpleGrantedAuthority> authorities = Set.of(
                new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
        );

        return jwtService.generateToken(email, authorities);
    }


    // Registers new admin user and generates JWT token
    public String registerAdmin(String email, String password, String fullName, String location, LocalDateTime birthday) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("User already exists");
        }

        var user = User.builder()
                .email(email)
                .password(passwordEncoder.encode(password))
                .fullName(fullName)
                .location(location)
                .birthday(birthday)
                .role(Role.USER) // Default role
                .build();

        userRepository.save(user);

        Set<SimpleGrantedAuthority> authorities = Set.of(
                new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
        );

        return jwtService.generateToken(email, authorities);
    }

    // Deletes user by email
    public void deleteUser(String email) {
        var user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));
        userRepository.delete(user);
    }

    // Retrieves all users from repository
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}