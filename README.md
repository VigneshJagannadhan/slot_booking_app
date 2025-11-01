# 🎯 MediBook - Slot Booking App

A Flutter-based medical appointment booking system that enables patients to book appointments with doctors and manage their healthcare scheduling.

## 📋 About

MediBook is a cross-platform mobile application built with Flutter that connects patients with healthcare providers. The app features user authentication, doctor listings, appointment management, and a clean, responsive user interface designed for both patients and doctors.

## 🏗️ Architecture

The app follows **Clean Architecture** principles with a clear separation of concerns:

- **Presentation Layer**: BLoC pattern for state management, screens, and UI components
- **Domain Layer**: Business logic, entities, repository interfaces, and use cases
- **Data Layer**: Repository implementations, data sources, and data models

Each feature is organized into these three layers, ensuring maintainability, testability, and scalability.

## 📁 Project Structure

```
lib/
├── features/              # Feature-based modules
│   ├── auth/             # Authentication (login, register, user management)
│   ├── appointments/     # Appointment CRUD operations
│   └── home/             # Doctor listings and home screens
│
├── core/                 # Core functionality
│   ├── di/              # Dependency injection (GetIt)
│   ├── routes/          # App navigation
│   ├── services/        # API client
│   ├── helpers/         # Utility helpers
│   └── themes/          # App styling and themes
│
└── utils/               # Shared utilities and constants
```

## 🚀 Features

- **Authentication**: User registration, login with JWT token management
- **Role-Based Access**: Separate interfaces for patients and doctors
- **Doctor Listings**: Browse available doctors with pagination
- **Appointment Management**: Create, read, update, and delete appointments
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Offline Support**: Network connectivity detection
- **Secure Storage**: JWT tokens stored using Flutter Secure Storage

## 🛠️ Tech Stack

**Core**
- Flutter 3.7.2+
- Dart

**State Management**
- flutter_bloc

**Networking**
- Dio
- connectivity_plus

**Dependency Injection**
- get_it

**Local Storage**
- shared_preferences
- flutter_secure_storage

**UI/UX**
- flutter_screenutil
- lottie
- google_fonts

**Utilities**
- fpdart
- equatable
- flutter_dotenv

## 🏛️ Architecture Pattern

- **Clean Architecture**: Three-layer architecture (Presentation, Domain, Data)
- **BLoC Pattern**: Predictable state management
- **Repository Pattern**: Data layer abstraction
- **Dependency Injection**: Service locator pattern with GetIt
- **SOLID Principles**: Applied throughout the codebase

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.29.3 or higher
- Dart SDK

### Installation

1. Clone the repository
   ```bash
   git clone <repository-url>
   cd slot_booking_app
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Create `.env` file in root directory
   ```
   BASE_URL=your_api_url_here
   ```

4. Run the application
   ```bash
   flutter run
   ```

This project is part of a portfolio demonstrating professional Flutter development skills and clean architecture implementation.

---
