# UniConnect Mobile App

UniConnect is a Flutter-based mobile application designed for university students, staff, and alumni to discover, book, and manage campus events. This app provides a seamless experience for event browsing, booking, and community engagement, with a focus on usability, security, and localization.

---

## Features

- **Event Discovery:** Browse upcoming university events with detailed information, images, and locations.
- **Event Booking:** RSVP for events directly from the app and manage your bookings.
- **Search:** Quickly search for events by name, location, or date.
- **Profile Management:** View and manage your profile, including logout and account deletion.
- **Localization:** Multi-language support using Flutter's localization tools.
- **Persistent Navigation:** Smooth navigation with a persistent bottom navigation bar.
- **Secure Storage:** User authentication tokens and profile details are securely stored.
- **Custom Animations:** Engaging Lottie animations for loading, success, and error states.
- **Theming & Fonts:** Custom fonts and consistent theming for a modern look.

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.4.3 <4.0.0)
- [Dart SDK](https://dart.dev/get-dart)
- A device or emulator for iOS/Android

### Installation

1. **Clone the repository:**
   ```sh
   git clone <https://github.com/Deshal-001/UniConnect.git>
   cd mobile_flutter
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

---

## Project Structure

- `lib/feature/event/` - Event-related pages, widgets, and BLoC logic
- `lib/feature/authentication/` - Login and authentication logic
- `lib/feature/shared/` - Shared screens like profile and splash
- `lib/core/widget/` - Custom widgets (buttons, alerts, etc.)
- `lib/core/network/` - Token and user data management
- `lib/core/providers/` - State providers for events and user
- `lib/core/utils/l10n/` - Localization files (ARB)
- `assets/` - Images, icons, fonts, and Lottie animations

---

## Key Packages Used

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) - State management
- [`provider`](https://pub.dev/packages/provider) - Dependency injection and state
- [`flutter_secure_storage`](https://pub.dev/packages/flutter_secure_storage) - Secure local storage
- [`persistent_bottom_nav_bar`](https://pub.dev/packages/persistent_bottom_nav_bar) - Bottom navigation
- [`lottie`](https://pub.dev/packages/lottie) - Animations
- [`intl`](https://pub.dev/packages/intl) - Internationalization
- [`dio`](https://pub.dev/packages/dio) & [`retrofit`](https://pub.dev/packages/retrofit) - Networking
- [`json_serializable`](https://pub.dev/packages/json_serializable) - JSON parsing

---

## Assets

- Place your images in `assets/images/`
- Place your icons in `assets/icons/`
- Place your Lottie animations in `assets/animations/`
- Custom fonts are in `assets/fonts/`

---

## Localization

- ARB files are located in `lib/core/utils/l10n/arb/`
- To generate localization files, run:
  ```sh
  flutter gen-l10n --arb-dir=lib/core/utils/l10n/arb/
  ```

---

## Customization

- **App Name & Description:** Edit in `pubspec.yaml`
- **Versioning:** Update the `version:` field in `pubspec.yaml`
- **Theme & Fonts:** Customize in `lib/core/widget/` and `pubspec.yaml`

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Create a new Pull Request

---

## License

This project is intended for educational and internal university use only.

---

## Contact

For support or questions, please contact the UniConnect development team.
