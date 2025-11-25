import Flutter
import UIKit

public class ScreenProtectionPlugin: NSObject, FlutterPlugin {

  var secureWindow: UIWindow?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "screen_protection",
      binaryMessenger: registrar.messenger()
    )
    let instance = ScreenProtectionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(
    _ call: FlutterMethodCall,
    result: @escaping FlutterResult
  ) {

    switch call.method {

    case "enable":
      enableProtection()
      result(true)

    case "disable":
      disableProtection()
      result(true)

    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)

    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func enableProtection() {
    guard secureWindow == nil else { return }

    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.windowLevel = .alert + 1

      // Add Blur Effect
      let blurEffect = UIBlurEffect(style: .regular)
      let blurView = UIVisualEffectView(effect: blurEffect)
      blurView.frame = window.bounds
      blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

      window.addSubview(blurView)
      window.isHidden = false

      secureWindow = window
    }
  }

  private func disableProtection() {
    secureWindow?.isHidden = true
    secureWindow = nil
  }
}
