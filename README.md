# Stack Viewer

A Flutter application that allows users to browse and search Stack Exchange questions. The app follows clean architecture principles and provides a responsive UI for different screen sizes.

## Features

- Browse Stack Exchange questions
- View question details
- Offline caching of questions
- Responsive design for different screen sizes
- Clean architecture implementation

## Architecture

The app follows clean architecture principles with the following layers:

- **Presentation Layer**: Contains UI components, BLoC for state management
- **Domain Layer**: Contains business logic, entities, and use cases
- **Data Layer**: Contains repositories, data sources, and models

## Technologies Used

- Flutter
- BLoC for state management
- GetIt for dependency injection
- Dio for network requests
- SQLite for local storage
- Clean Architecture

## Getting Started

### Prerequisites

- Flutter SDK
- Android Studio or VS Code
- Git

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/stack_viewer.git
   ```

2. Navigate to the project directory
   ```
   cd stack_viewer
   ```

3. Install dependencies
   ```
   flutter pub get
   ```

4. Run the app
   ```
   flutter run
   ```

## Building for Release

To build a release APK:

```
flutter build apk --release
```

The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Stack Exchange API for providing the data
- Flutter team for the amazing framework
