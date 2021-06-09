import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    static let IOS_CHANNEL = "thecove.hashcove.com/channel"
    var rsa_channel:FlutterMethodChannel!
    let dbHelper = DatabaseHelper();
    private var controller:FlutterViewController!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
    controller = window?.rootViewController as? FlutterViewController
    rsa_channel = FlutterMethodChannel(name:AppDelegate.IOS_CHANNEL,
                                       binaryMessenger: controller as! FlutterBinaryMessenger)
    
    
    rsa_channel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
    
        if(call.method == "getSharedPath"){
            let sharedPath = self?.dbHelper.getSharedContainerDirectoryPath()
            result(sharedPath)
        }
        if(call.method == "openIosDb"){
            self?.dbHelper.openDb()
            result(nil)
        }
    
  })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
}
