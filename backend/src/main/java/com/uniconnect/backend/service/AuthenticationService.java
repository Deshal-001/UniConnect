package com.uniconnect.backend.service;

import com.uniconnect.backend.model.Role;
import com.uniconnect.backend.model.User;
import com.uniconnect.backend.repository.UserRepository;
import com.uniconnect.backend.security.JwtService;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

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

    public String register(String email, String password) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new RuntimeException("User already exists");
        }

        // Use Lombok's @Builder to create User
        var user = User.builder()
                .email(email)
                .password(passwordEncoder.encode(password))
                .role(Role.USER) // Default role
                .build();

        userRepository.save(user);

        // Create authorities from single Role enum
        Set<SimpleGrantedAuthority> authorities = Set.of(
                new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
        );

        return jwtService.generateToken(email, authorities);
    }

    public List<User> getAllUsers(){
        return  userRepository.findAll();
    }
}