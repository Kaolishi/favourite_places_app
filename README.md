# Favourite Places App 

A Flutter mobile application that allows users to capture and save their favorite locations with photos. Users can add places by taking pictures, getting their current GPS location, or manually selecting locations on an interactive map.

## Features 

- **Photo Capture**: Take pictures using the device camera to associate with places
- **Interactive Maps**: View and select locations using Google Maps
- **GPS Location**: Get current location automatically using device GPS
- **Local Storage**: Persist data using SQLite database
- **Modern UI**: Dark theme with beautiful Material Design 3 interface
- **Cross-platform**: Runs on both Android and iOS devices

## Tech Stack 

- **Framework**: Flutter 3.32.8
- **State Management**: Riverpod
- **Database**: SQLite (sqflite)
- **Maps**: Google Maps Flutter
- **Location Services**: Location package
- **Image Handling**: Image Picker
- **HTTP Requests**: HTTP package for geocoding
- **Typography**: Google Fonts (Ubuntu Condensed)

## Project Structure 

```
lib/
├── main.dart                 # App entry point and theme configuration
├── config/
│   ├── api_config.dart       # API keys configuration
│   └── api_config.dart.example # Template for API configuration
├── models/
│   └── place.dart           # Data models for Place and PlaceLocation
├── providers/
│   └── user_places.dart     # Riverpod state management and database operations
├── screens/
│   ├── places.dart          # Main screen displaying list of places
│   ├── add_place.dart       # Form screen for adding new places
│   ├── map.dart             # Interactive Google Maps screen
│   └── place_detail.dart    # Detailed view of a selected place
└── widgets/
    ├── image_input.dart     # Camera capture widget
    ├── location_input.dart  # Location selection widget (GPS/Map)
    └── places_list.dart     # List widget for displaying places
```

## Prerequisites 

- Flutter SDK (3.32.8 or later)
- Android Studio / VS Code
- Android device/emulator or iOS device/simulator
- Google Maps API key

## Setup Instructions 

### 1. Clone the Repository
```bash
git clone https://github.com/Kaolishi/favourite_places_app.git
cd favourite_places_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Google Maps API

1. Get a Google Maps API key from [Google Cloud Console](https://console.cloud.google.com/)
2. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Geocoding API
   - Maps Static API

3. Copy the API configuration template:
```bash
cp lib/config/api_config.dart.example lib/config/api_config.dart
```

4. Edit `lib/config/api_config.dart` and add your API key:
```dart
class ApiConfig {
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY_HERE';
}
```

### 4. Configure Android

Add your API key to `android/app/src/main/AndroidManifest.xml`:

```xml
<application>
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
</application>
```

### 5. Configure iOS (if targeting iOS)

Add your API key to `ios/Runner/AppDelegate.swift`:

```swift
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY_HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### 6. Run the App
```bash
flutter run
```

## Permissions 

The app requires the following permissions:

### Android (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

### iOS (`ios/Runner/Info.plist`):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to mark your favorite places.</string>
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos of your favorite places.</string>
```

## Dependencies 

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  google_fonts: ^6.2.1
  google_maps_flutter: ^2.18.2
  location: ^8.0.1
  image_picker: ^1.2.2
  http: ^1.2.2
  path_provider: ^2.1.5
  path: ^1.9.1
  sqflite: ^2.4.1
  uuid: ^4.5.1
```

## How to Use 

1. **Launch the app** - You'll see the main screen with your saved places
2. **Add a new place** - Tap the '+' button in the app bar
3. **Enter details**:
   - Add a title for your place
   - Take a photo using the camera
   - Choose location method:
     - **Get Current Location**: Uses GPS to get your current position
     - **Select on Map**: Choose location manually on the interactive map
4. **Save the place** - Tap "Add Place" to save
5. **View details** - Tap any place in the list to see full details
6. **View on map** - In detail view, tap the map preview to open full map

## Building for Release 

### Android APK:
```bash
flutter build apk --release
```

### Android App Bundle:
```bash
flutter build appbundle --release
```

### iOS:
```bash
flutter build ios --release
```

## Troubleshooting 

### Common Issues:

1. **Maps not loading**: Ensure your Google Maps API key is correctly configured
2. **Location not working**: Check that location permissions are granted
3. **Camera not working**: Verify camera permissions are granted
4. **Build errors**: Run `flutter clean` and `flutter pub get`

### Debug Commands:
```bash
flutter doctor          # Check Flutter installation
flutter clean           # Clean build files
flutter pub get         # Get dependencies
flutter run -v          # Run with verbose output
```

## Contributing 

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## License 

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support 

If you have any questions or issues, please open an issue on GitHub or contact the maintainer.

---

**Built using Flutter**
