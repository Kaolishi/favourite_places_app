import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Read Google Maps API key from Info.plist (injected during build)
    guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
          let plist = NSDictionary(contentsOfFile: path),
          let apiKey = plist["GOOGLE_MAPS_API_KEY"] as? String,
          !apiKey.isEmpty && !apiKey.contains("$(") else {
      print("Warning: Google Maps API key not properly configured in Info.plist")
      print("Make sure to build with: flutter build ios --dart-define=GOOGLE_MAPS_API_KEY=your_key")
      GMSServices.provideAPIKey("") // Empty key as fallback
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    GMSServices.provideAPIKey(apiKey)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}