package com.uniconnect.backend.service;

import com.uniconnect.backend.exception.ApiException;
import com.uniconnect.backend.exception.ErrorCodes;
import com.uniconnect.backend.model.Role;
import com.uniconnect.backend.model.University;
import com.uniconnect.backend.model.User;
import com.uniconnect.backend.repository.UniversityRepository;
import com.uniconnect.backend.repository.UserRepository;
import com.uniconnect.backend.security.JwtService;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
public class AuthenticationService {

    private final JwtService jwtService;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final UniversityRepository universityRepository;

    public AuthenticationService(
            JwtService jwtService,
            UserRepository userRepository,
            UniversityRepository universityRepository,
            PasswordEncoder passwordEncoder
    ) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.universityRepository = universityRepository;
    }

    // Authenticates user and generates JWT token
    public String login(String email, String password) {
        var user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ApiException(ErrorCodes.USER_NOT_FOUND));
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new ApiException(ErrorCodes.INVALID_PASSWORD);
        }

        Set<SimpleGrantedAuthority> authorities = Set.of(
                new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
        );

        return jwtService.generateToken(email, authorities);
    }

    // Registers new user with default USER role and generates JWT token
    public String register(String email, String password, String fullName, String location, LocalDateTime birthday, Long uniId, String imgUrl) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new ApiException(ErrorCodes.USER_ALREADY_EXISTS);
        }

        University university = universityRepository.findById(uniId)
                .orElseThrow(() -> new ApiException(ErrorCodes.UNIVERSITY_NOT_FOUND));

        var user = User.builder()
                .email(email)
                .password(passwordEncoder.encode(password))
                .fullName(fullName)
                .location(location)
                .birthday(birthday)
                .role(Role.USER)
                .imgUrl(imgUrl)
                .university(new University(university.getId(), university.getName(), university.getLocation(),university.getImgUrl()))
                .build();
        userRepository.save(user);

        Set<SimpleGrantedAuthority> authorities = Set.of(
                new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
        );

        return jwtService.generateToken(email, authorities);
    }

    // Registers new admin user and generates JWT token
    public String registerAdmin(String email, String password, String fullName, String location, LocalDateTime birthday, Long uniId, String imgUrl) {
        if (userRepository.findByEmail(email).isPresent()) {
            throw new ApiException(ErrorCodes.USER_ALREADY_EXISTS);
        }

        University university = universityRepository.findById(uniId)
                .orElseThrow(() -> new ApiException(ErrorCodes.UNIVERSITY_NOT_FOUND));

        var user = User.builder()
                .email(email)
                .password(passwordEncoder.encode(password))
                .fullName(fullName)
                .location(location)
                .birthday(birthday)
                .role(Role.ADMIN)
                .imgUrl(imgUrl)
                .university(new University(university.getId(), university.getName(), university.getLocation(),university.getImgUrl()))
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
                .orElseThrow(() -> new ApiException(ErrorCodes.USER_NOT_FOUND));
        userRepository.delete(user);
    }

    // Retrieves all users from repository
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> findUserByEmail(String email){
        return userRepository.findByEmail(email);

    }
}