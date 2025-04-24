# JWT Service Documentation

## Overview

The `JwtService` is a critical component of the Spring Boot REST API’s security system, managing the creation, validation, and data extraction of JSON Web Tokens (JWTs). It enables secure, stateless authentication by generating tokens for users and verifying them in requests to protected endpoints (e.g., `/api/event/**`, `/api/admin/**`).

## Purpose

- Generate JWTs during login or registration, embedding user email and roles.
- Validate JWTs to ensure they are authentic and not expired.
- Extract user details (email, roles) from tokens for authentication and access control.

## Why Use It?

- **Stateless Authentication**: Creates self-contained JWTs, supporting a stateless API without server-side sessions.
- **Security**: Signs tokens with a secret key to prevent tampering.
- **Role-Based Access**: Embeds roles (e.g., `USER`, `ADMIN`) for endpoint restrictions.
- **Efficiency**: Centralizes JWT operations, simplifying authentication logic.

## Challenges Faced Before Implementation

- **Manual Token Creation**: Crafting tokens without a service was error-prone and inconsistent.
- **Inconsistent Validation**: Lack of centralized validation led to security gaps.
- **Role Management**: Embedding and extracting roles was unreliable, risking unauthorized access.
- **Session Overhead**: Session-based authentication required server-side storage, hindering scalability.

## Code Explanation

The `JwtService` class handles JWT operations using the `io.jsonwebtoken` library. Below is a simplified explanation of its key methods:

- **Secret Key Setup**:
  - Uses a hardcoded secret key to sign tokens (for learning; should use environment variables in production).
  - Converts the key into a format for secure signing.

- **Generate Token**:
  - Creates a JWT for a user, including their email (as the subject) and roles (e.g., `ROLE_USER`).
  - Sets the token’s issuance time, expiration (24 hours), and signs it with the secret key.
  - Output: A compact string (e.g., `eyJ...`).

- **Extract Claims**:
  - Parses a JWT to retrieve all data (claims), like email, roles, and expiration, using the secret key to verify the signature.

- **Extract Username**:
  - Gets the user’s email (subject) from the token’s claims.

- **Extract Roles**:
  - Retrieves the list of roles (e.g., `["ROLE_USER"]`) from the token’s claims.

- **Validate Token**:
  - Checks if the token’s email matches the provided email and if the token hasn’t expired.
  - Returns `true` if valid, `false` otherwise.

- **Check Expiration**:
  - Compares the token’s expiration date to the current time to determine if it’s expired.

## Maintenance

- Store the secret key in environment variables for production security.
- Adjust token expiration time (e.g., shorter for sensitive operations).
- Plan for CSRF integration when enabling frontend support.