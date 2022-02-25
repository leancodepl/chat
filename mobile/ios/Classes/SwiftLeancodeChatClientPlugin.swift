import Flutter
import UIKit

public class SwiftLeancodeChatClientPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "leancode_chat_client", binaryMessenger: registrar.messenger())
        let instance = SwiftLeancodeChatClientPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case "clearNotificationsWithTag":
            guard #available(iOS 10.0, *) else {
                result(FlutterError.init(
                    code: "UNSUPPORTED_IOS_VERSION",
                    message: "This method requires iOS 10 or newer",
                    details: nil
                ))
                return
            }

            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(FlutterError.init(
                    code: "INVALID_ARGS",
                    message: "Args should be a dictionary",
                    details: nil
                ))
                return
            }
            
            let threadId = args["tag"] as? String
            let notificationCenter = UNUserNotificationCenter.current()
            
            notificationCenter.getDeliveredNotifications { (notifications) in
                let threadNotificationIds = notifications
                    .filter { $0.request.content.threadIdentifier == threadId }
                    .map { $0.request.identifier }
                
                notificationCenter.removeDeliveredNotifications(withIdentifiers: threadNotificationIds)
            }
    
            result(nil)
        default:
            break
        }
    }
}
