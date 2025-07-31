# 🎓 UniConnect — University Event Booking Platform

**UniConnect** is a full-stack event booking and management platform developed for universities, built with a scalable architecture and modern technologies. It enables students, staff, and admins to discover, manage, and organize campus events through a **Flutter mobile app**, **Angular-based admin dashboard**, and **Spring Boot backend**.

> 🚀 This system was built as a real-world solution for academic institutions but is adaptable for any organization hosting internal or public events.

---

## 🧱 System Architecture

- 📱 **Mobile App** – Flutter (`/mobile/mobile_flutter`)
- 🖥️ **Admin Panel** – Angular (`/admin_panel/uniconnect-admin-panel-angular`)
- ⚙️ **Backend** – Spring Boot + PostgreSQL (`/backend`)
- ☁️ **Deployment** – CI/CD with GitHub Actions + Render/AWS (in progress)

---

## ✨ Features

### 🔵 Mobile App (Flutter)
- Event listing and discovery with images and filtering
- Secure booking & ticket generation
- QR code check-in for participants
- Authentication (Sign up/login/logout)
- Profile management
- Multilingual support (localization)
- Persistent bottom navigation bar
- Clean architecture using BLoC and Provider

### 🟢 Admin Dashboard (Angular)
- Admin login (JWT-based)
- Event creation, update, and deletion
- Booking overview & participant management
- Dashboard metrics and filtering
- Role-based access control (future enhancement)

### 🟡 Backend (Spring Boot)
- REST API with DTOs and validation
- JWT authentication
- User roles (Admin, User)
- Event & booking APIs
- PostgreSQL database integration
- Dockerfile & CI workflows

---

## 🧪 Tech Stack

| Layer        | Technologies |
|--------------|--------------|
| Mobile       | Flutter, Dart, flutter_bloc, dio, retrofit |
| Admin Panel  | Angular 17+, TypeScript, Angular Material |
| Backend      | Java 17, Spring Boot, PostgreSQL, JWT, Maven |
| DevOps       | GitHub Actions, Docker, Render (target) |

---

## 🚀 Setup Instructions

### 1. Clone the Repo

```bash
git clone https://github.com/Deshal-001/UniConnect.git
cd UniConnect
```

### 2. Mobile App

```bash
cd mobile/mobile_flutter
flutter pub get
flutter run
```

### 3. Backend (Spring Boot)

```bash
cd backend
./mvnw spring-boot:run
```

### 4. Admin Panel (Angular)

```bash
cd admin_panel/uniconnect-admin-panel-angular
npm install
ng serve
```

---

## 📁 Repository Structure

```
UniConnect/
│
├── mobile/                           # Flutter app
│   └── mobile_flutter/
│
├── admin_panel/                     # Angular admin panel
│   └── uniconnect-admin-panel-angular/
│
├── backend/                         # Spring Boot API
│
├── docs/                            # Technical docs and architecture
├── .github/workflows/               # CI/CD workflows
└── README.md                        # You are
