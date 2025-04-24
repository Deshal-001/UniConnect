# Security Documentation

## Overview

The Spring Boot REST API implements security using **JSON Web Token (JWT)** authentication and **role-based access control** to protect endpoints and ensure only authorized users can access resources. This documentation describes the current security setup, including JWT generation, validation, and role-based restrictions, applied in `AuthenticationService` and configured in `SecurityConfig`.

## Purpose

- Authenticate users via JWTs for secure access to protected endpoints (e.g., `/api/event/**`).
- Restrict access to specific endpoints (e.g., `/api/admin/**`) based on user roles (`USER`, `ADMIN`).
- Provide a foundation for future CSRF protection when integrating with the frontend.

## Implementation

### JWT Authentication

JWTs are used to authenticate users without server-side session storage. The process involves:
- **Generation**: Users receive a JWT upon successful login or registration via `/api/auth/**` endpoints.
- **Validation**: Each request to protected endpoints includes a JWT in the `Authorization` header, validated by the `JwtAuthenticationFilter`.

#### Key Components

1. **AuthenticationService**:
   - Handles user login and registration, generating JWTs.
   - **Login**: Verifies email and password, then generates a JWT with user role (`ROLE_USER` or `ROLE_ADMIN`).
   - **Registration**: Creates a new user (`USER` or `ADMIN` role) and generates a JWT.
   - Example:
     ```java
     public String login(String email, String password) {
         var user = userRepository.findByEmail(email)
                 .orElseThrow(() -> new ApiException(ErrorCode.USER_NOT_FOUND));
         if (!passwordEncoder.matches(password, user.getPassword())) {
             throw new ApiException(ErrorCode.INVALID_PASSWORD);
         }
         Set<SimpleGrantedAuthority> authorities = Set.of(
                 new SimpleGrantedAuthority("ROLE_" + user.getRole().name())
         );
         return jwtService.generateToken(email, authorities);
     }
     ```

2. **JwtService**:
   - Generates and validates JWTs using a secret key.
   - Embeds the user’s email and role in the token.
   - Validates tokens by checking signature and expiration.

3. **JwtAuthenticationFilter**:
   - Intercepts requests to extract and validate the JWT from the `Authorization` header.
   - Sets the authenticated user in the Spring Security context if the token is valid.
   - Example:
     ```java
     public class JwtAuthenticationFilter extends OncePerRequestFilter {
         private final JwtService jwtService;
         // Constructor and methods
         @Override
         protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
                 throws ServletException, IOException {
             String authHeader = request.getHeader("Authorization");
             if (authHeader != null && authHeader.startsWith("Bearer ")) {
                 String token = authHeader.substring(7);
                 // Validate token and set authentication
             }
             filterChain.doFilter(request, response);
         }
     }
     ```

### Role-Based Access Control

Access to endpoints is restricted based on user roles (`USER`, `ADMIN`):
- **Public Endpoints**: `/api/auth/**` (login, registration) are accessible without authentication.
- **Protected Endpoints**: `/api/event/**` requires authentication (any role).
- **Admin Endpoints**: `/api/admin/**` requires the `ADMIN` role.

### Security Configuration

The `SecurityConfig` class configures Spring Security to enforce JWT authentication and role-based access.

**Example**:
```java
package com.uniconnect.backend.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    public SecurityConfig(JwtAuthenticationFilter jwtAuthenticationFilter) {
        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // CSRF disabled, to be enabled later
            .cors(cors -> cors.configurationSource(corsConfigurationSource()))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .requestMatchers("/api/event/**").authenticated()
                .anyRequest().authenticated()
            )
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(List.of("http://localhost:3000"));
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("Authorization", "Content-Type"));
        configuration.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
```

**Key Settings**:
- **CSRF**: Disabled (`csrf.disable()`) as it’s not yet needed; will be enabled for frontend integration.
- **CORS**: Allows requests from `http://localhost:3000` for frontend development.
- **Session Management**: Stateless (`SessionCreationPolicy.STATELESS`) to rely on JWTs, not server-side sessions.
- **Authorization**:
  - `/api/auth/**`: Public.
  - `/api/event/**`: Requires authentication.
  - `/api/admin/**`: Requires `ADMIN` role.
- **JwtAuthenticationFilter**: Validates JWTs before Spring Security’s default authentication filter.

## Future Enhancements

- **CSRF Protection**: Plan to enable CSRF using `CookieCsrfTokenRepository` for state-changing endpoints (e.g., POST, DELETE) when integrating with the frontend.
- **Additional Security**: Consider adding rate limiting, password strength validation, or OAuth2 for enhanced security.

## Maintenance

- Update `JwtService` secret key periodically for security.
- Adjust CORS settings for production (`allowedOrigins`).
- Add new roles or endpoint restrictions in `SecurityConfig` as needed.