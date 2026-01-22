import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late final String mapKey;
  static late final String baseURl;
  static late final String geminiApiKey;

  static void init() {
    mapKey = _getEnv('MAP_KEY');
    baseURl = _getEnv('API_URL');
    geminiApiKey = _getEnv('GEMINI_API_KEY');
  }

  static String _getEnv(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw Exception('Missing environment variable: $key');
    }
    return value;
  }
}
