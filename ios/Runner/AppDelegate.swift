import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
	let root = self.window.rootViewController as! FlutterViewController
	let
	channel = FlutterMethodChannel.init(name: "samples.flutter.io/battery", binaryMessenger: root as! FlutterBinaryMessenger)
	  
	channel.setMethodCallHandler { (call: FlutterMethodCall, retult: FlutterResult) in
		 
		if call.method=="getBatteryLevel"{
			let ret = self.getBattery()
			
			if ret == -1{
				retult(FlutterError.init(code: "-1", message: "无法获取电池用量", details: nil))
			}else{
				retult(Int(ret*100))
			}
		}else{
			retult(FlutterMethodNotImplemented)
		}
	}
	
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
	func getBattery() -> Float {
		let device = UIDevice.current
		device.isBatteryMonitoringEnabled=true
 		if UIDevice.current.batteryState == UIDevice.BatteryState.unknown
		{
			return -1
		}
		return UIDevice.current.batteryLevel;
		
	}
}
