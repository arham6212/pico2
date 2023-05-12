
import 'default_env.dart';

class Configuration {
  static String _baseUrl = DefaultConfig.baseUrl;
  static String _appName = DefaultConfig.appName;
  static bool _enableCrashAnalytics = DefaultConfig.enableCrashAnalytics;
  static bool _defaultDarkTheme = DefaultConfig.defaultDarkTheme;
  static String _countryCodeDefault = DefaultConfig.countryCodeDefault;
  static String _dialCodeDefault = DefaultConfig.dialCodeDefault;
  static String _nameDefault = DefaultConfig.nameDefault;

  static String get baseUrl => _baseUrl;
  static String get appName => _appName;
  static bool get enableCrashAnalytics => _enableCrashAnalytics;
  static bool get defaultDarkTheme => _defaultDarkTheme;
  static String get countryCodeDefault => _countryCodeDefault;
  static String get dialCodeDefault => _dialCodeDefault;
  static String get nameDefault => _nameDefault;

  void setConfigurationValues(Map<String, dynamic> value) {
    _baseUrl = value['baseUrl'] ?? DefaultConfig.baseUrl;
    _appName = value['app_name'] ?? DefaultConfig.appName;
    _enableCrashAnalytics =
        value['enableCrashAnalytics'] ?? DefaultConfig.enableCrashAnalytics;
    _defaultDarkTheme =
        value['defaultDarkTheme'] ?? DefaultConfig.defaultDarkTheme;
    _countryCodeDefault =
        value['countryCodeDefault'] ?? DefaultConfig.countryCodeDefault;
    _dialCodeDefault =
        value['dialCodeDefault'] ?? DefaultConfig.dialCodeDefault;
    _nameDefault = value['nameDefault'] ?? DefaultConfig.nameDefault;
  }
}