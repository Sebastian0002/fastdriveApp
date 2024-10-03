import Flutter
import UIKit
import CoreLocation
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager?
    var permissionEventSink: FlutterEventSink?
    
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyBXfOX3sNQh9dAjsDSuQxQVVWyPyboa0vw")
        GeneratedPluginRegistrant.register(with: self)
        
        guard let controller = window?.rootViewController as? FlutterViewController else {
              fatalError("rootViewController is not type FlutterViewController")}
         let permissionChannel = FlutterEventChannel(name: "com.fastdrive.location/permissions", binaryMessenger: controller.binaryMessenger)
        permissionChannel.setStreamHandler(self)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func requestLocationPermissions() {
        locationManager?.requestWhenInUseAuthorization()
    }

    func checkLocationPermissions() {
        let status = CLLocationManager.authorizationStatus()
        var isPermissionGranted = false
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            isPermissionGranted = true
        case .denied, .restricted, .notDetermined:
            isPermissionGranted = false
        @unknown default:
            break
        }
        
        permissionEventSink?(isPermissionGranted)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationPermissions()
    }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
            self.permissionEventSink = events
            checkLocationPermissions()
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.permissionEventSink = nil
        return nil
    }
}
