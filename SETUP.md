# Project Setup Instructions

## 1. Google Maps API Key
To run the application with Google Maps features, you need a Google Maps API Key.

1.  Go to [Google Cloud Console](https://console.cloud.google.com/).
2.  Create a project and enable **Maps SDK for Android** and **Maps SDK for iOS**.
3.  Get the API Key.

### Android
Open `android/app/src/main/AndroidManifest.xml` and replace `YOUR_GOOGLE_MAPS_API_KEY` with your actual key.

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="AIzaSy..." />
```

### iOS
Open `ios/Runner/AppDelegate.swift` (or `AppDelegate.m`) and provide the API Key in `GMSServices.provideAPIKey("YOUR_KEY")`.
Also, add the following to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs your location to show nearby places.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs your location to show nearby places.</string>
```

## 2. Dependencies
Ensure you have enabled Developer Mode if on Windows to allow symlinks for plugins.
Run:
```bash
flutter pub get
```

## 3. Icons
Using standard icons. To update launcher icons, use `flutter_launcher_icons` package if needed.

## 4. Running
```bash
flutter run
```
