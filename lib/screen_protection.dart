import 'screen_protection_platform_interface.dart';
import 'package:flutter/services.dart';

class ScreenProtection {
  Future<String?> getPlatformVersion() {
    return ScreenProtectionPlatform.instance.getPlatformVersion();
  }

  static const MethodChannel _channel = MethodChannel('screen_protection');

  static Future<void> enableProtection() async {
    await _channel.invokeMethod('enable');
  }

  static Future<void> disableProtection() async {
    await _channel.invokeMethod('disable');
  }
}
