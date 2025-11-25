import Flutter
import UIKit

public class ScreenProtectionPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "screen_protection", binaryMessenger: registrar.messenger())
    let instance = ScreenProtectionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let window = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first else {
        result(FlutterError(code: "NO_WINDOW", message: "No active window found", details: nil))
        return
    }

    switch call.method {

    case "enable":
      // منع تصوير الشاشة + تسجيل الشاشة
      window.isHidden = false
      window.screen?.isCapturedDidChangeNotification
      window.layer.superlayer?.addSublayer(CALayer())   // Hardening
      window.isSecureTextEntry = true
      result(true)

    case "disable":
      // إلغاء المنع
      window.isSecureTextEntry = false
      result(true)

    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
