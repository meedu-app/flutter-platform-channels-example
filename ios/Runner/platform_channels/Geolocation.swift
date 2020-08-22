
import Foundation
import CoreLocation

class Geolocation: NSObject, CLLocationManagerDelegate {
    
    let manager: CLLocationManager = CLLocationManager()
    var flutterResult: FlutterResult?
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("user action 😅")
        if self.flutterResult != nil {
            self.sendStatus(result: self.flutterResult!, status: status)
            self.flutterResult = nil
        }
    }
    
    init(messenger: FlutterBinaryMessenger) {
        super.init()
        let channel = FlutterMethodChannel(name: "app.meedu/geolocation", binaryMessenger: messenger)
        channel.setMethodCallHandler(self.callHandler)
        self.manager.delegate = self
    }
    
    private func callHandler(call:FlutterMethodCall, result:@escaping FlutterResult) {
        switch call.method {
        case "check":
            check(result: result)
        case "request":
            let args =  call.arguments as! [String:Any]
            let openAppSettings: Bool = args["openAppSettings"] as! Bool
            if self.flutterResult != nil {
                result(FlutterError(code: "PENDING_TASK", message: "You have a pending task", details: nil))
            }else{
             self.flutterResult = result
                
                if openAppSettings {
                    print("open the app permission in Settings app")
                    // open the app permission in Settings app
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                }else{
                    self.manager.requestWhenInUseAuthorization()
                }
            
             
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    private func check(result:FlutterResult){
        let status:CLAuthorizationStatus =  CLLocationManager.authorizationStatus()
        self.sendStatus(result: result, status: status)
    }
    
    private func sendStatus(result: FlutterResult, status: CLAuthorizationStatus ){
        switch status {
              case .authorizedWhenInUse:
                  print("check 😁 granted")
                  result("granted")
              case .denied:
                   print("check 😁 denied")
                  result("denied")
              case .restricted:
                    print("check 😁 restricted")
                  result("restricted")
                  
              case .notDetermined:
                  print("check 😁 notDetermined")
                  result("unknown")
              default:
                    print("check 😁 unknown")
                  result("unknown")
              }
    }
    
}
