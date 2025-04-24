# JWT Authentication Filter Documentation

## Overview

The `JwtAuthenticationFilter` is a Spring Security component that authenticates users by validating JSON Web Tokens (JWTs) in HTTP requests, ensuring only authorized users access protected API endpoints (e.g., `/api/event/**`, `/api/admin/**`).

## Purpose

- Authenticate users by checking JWTs in the `Authorization` header.
- Enable role-based access control by extracting user roles (e.g., `USER`, `ADMIN`) from the token.
- Support a stateless API without server-side sessions.

## Why Use It?

- **Stateless Authentication**: Validates JWTs per request, avoiding session storage for scalability.
- **Security**: Ensures only valid, untampered tokens grant access.
- **Centralized Logic**: Handles authentication globally, reducing repetitive code in controllers.
- **Role Support**: Enables restrictions like `ADMIN`-only endpoints (`/api/admin/**`).

## Challenges Faced Before Implementation

- **Session-Based Authentication**: Server-side sessions were unscalable and complex for a stateless API.
- **Manual Token Checks**: Validating tokens in each controller was repetitive and error-prone.
- **Role Management**: Extracting roles from tokens was inconsistent, risking unauthorized access.
- **Invalid Tokens**: Early setups lacked proper handling for expired or invalid tokens, causing unclear errors.

## Maintenance

- Update the JWT secret key periodically.
- Plan for CSRF integration when enabling frontend support.