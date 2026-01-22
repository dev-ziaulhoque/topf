import '../../app_config/app_config.dart';

class EndPoint {
  // Base URL
  static String get baseUrl => AppConfig.baseURl;
  // Map
  static String get mapKey => AppConfig.mapKey;
  // gemini api key
  static String get geminiApiKey => AppConfig.geminiApiKey;

  // APIs
  static String get login => '$baseUrl/auth/login';
  static String get register => '$baseUrl/auth/register';
  static String get profile => '$baseUrl/user/profile';

}