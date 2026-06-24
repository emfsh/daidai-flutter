import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUserAgent {
  AppUserAgent._();

  static String _value = _fallbackUserAgent;
  static String _platform = _detectPlatform();
  static String _version = 'unknown';
  static String _buildNumber = '';
  static String _deviceModel = '';
  static String _osVersion = '';

  static String get value => _value;

  static Map<String, String> get defaultHeaders => {
    'User-Agent': _value,
    'X-Client-App': 'daidai-panel-app',
    'X-Client-Type': 'app',
    'X-Client-Platform': _platform,
    'X-Client-Version': versionLabel,
    if (_deviceModel.isNotEmpty) 'X-Device-Model': _deviceModel,
    if (_osVersion.isNotEmpty) 'X-OS-Version': _osVersion,
  };

  static String get versionLabel =>
      _buildNumber.isEmpty ? _version : '$_version+$_buildNumber';

  static Future<void> initialize() async {
    _platform = _detectPlatform();
    try {
      final info = await PackageInfo.fromPlatform();
      _version = info.version.trim().isEmpty ? 'unknown' : info.version.trim();
      _buildNumber = info.buildNumber.trim();
    } catch (_) {
      _version = 'unknown';
      _buildNumber = '';
    }
    await _loadDeviceInfo();
    _value = 'DaidaiPanelApp/$versionLabel (${_buildDetail()}; Flutter)';
  }

  static Future<void> _loadDeviceInfo() async {
    _deviceModel = '';
    _osVersion = '';
    if (kIsWeb) return;
    final plugin = DeviceInfoPlugin();
    try {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final info = await plugin.androidInfo;
          _deviceModel = '${info.manufacturer} ${info.model}'.trim();
          _osVersion = info.version.release.trim();
          return;
        case TargetPlatform.iOS:
          final info = await plugin.iosInfo;
          _deviceModel = info.utsname.machine.trim();
          _osVersion = info.systemVersion.trim();
          return;
        default:
          return;
      }
    } catch (_) {
      _deviceModel = '';
      _osVersion = '';
    }
  }

  static String _buildDetail() {
    final parts = <String>[_platformLabel()];
    if (_deviceModel.isNotEmpty) parts.add(_deviceModel);
    return parts.where((part) => part.isNotEmpty).join('; ');
  }

  static String _platformLabel() {
    if (_platform == 'android') return _osVersion.isEmpty ? 'Android' : 'Android $_osVersion';
    if (_platform == 'ios') return _osVersion.isEmpty ? 'iOS' : 'iOS $_osVersion';
    return _platform;
  }

  static String _detectPlatform() {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }

  static const String _fallbackUserAgent = 'DaidaiPanelApp/unknown (Flutter)';
}
