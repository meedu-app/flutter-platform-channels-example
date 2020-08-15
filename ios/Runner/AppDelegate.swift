import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: "app.meedu/my_first_platform_channel", binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler({(call: FlutterMethodCall, result: FlutterResult)-> Void in
            if call.method == "version" {
                let version =  UIDevice().systemVersion
                result("iOS \(version)")
            }else{
                result(FlutterMethodNotImplemented)
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
