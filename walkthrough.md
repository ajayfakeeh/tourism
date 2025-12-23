# Flutter Clean Architecture App Walkthrough

This application is a production-ready Flutter app built with Clean Architecture, Cubit, GetIt, Dio, and Google Maps.

## Project Structure
The project follows a strict strict clean architecture:

- **`lib/core`**: Core utilities, network clients, and error handling.
- **`lib/data`**: Implementation of repositories, API calls, and data models.
- **`lib/domain`**: Business logic, entities, and repository interfaces.
- **`lib/presentation`**: UI (Pages, Widgets) and State Management (Cubits).
- **`lib/di`**: Dependency Injection setup using GetIt.

## Features Implemented

### 1. Authentication
- **Login**: Simulates an API call to log in using phone number and password.
- **State**: `AuthCubit` manages `AuthLoading`, `AuthSuccess` (mocks user), and `AuthFailure`.
- **Files**:
    - `lib/presentation/pages/login_page.dart`
    - `lib/presentation/cubit/auth/auth_cubit.dart`
    - `lib/data/datasources/remote/auth_remote_datasource.dart`

### 2. Dashboard
- **Navigation**: Grid of buttons navigating to Map, Places, etc.
- **Files**:
    - `lib/presentation/pages/dashboard_page.dart`

### 3. Maps & Location
- **Google Maps**: Displays current location and allows setting a destination.
- **Route**: Mocks a polyline route between points.
- **Distance**: Calculates distance between user and destination.
- **Files**:
    - `lib/presentation/pages/map_page.dart`
    - `lib/presentation/cubit/map/map_cubit.dart`
    - `lib/domain/repositories/map_repository.dart`

### 4. Places
- **Listing**: Shows dummy places (Hotels, Tourist spots, etc.) based on type.
- **Add Place**: Form to add new places (mocked submission).
- **Files**:
    - `lib/presentation/pages/places_page.dart`
    - `lib/presentation/pages/add_place_page.dart`

## Next Steps for You
1.  **API Key**: You **MUST** add your Google Maps API Key in `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`. See `SETUP.md` for details.
2.  **Dependencies**: Run `flutter pub get` to install packages (ensure Developer Mode is on for Windows symlinks).
3.  **Run**: `flutter run` to start the app.

## Notes
- The "Login" and "Attributes" APIs are currently mocked in `RemoteDataSource` files. You can replace the `Future.delayed` calls with actual `dio.post()` calls when ready.
- The Map Route is mocked as a straight line. Enable Google Directions API and implement `flutter_polyline_points` or similar if you need real turn-by-turn polylines.
