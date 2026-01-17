import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoint {
  final mapKey = dotenv.env['MAP_KEY'];

  final apiUrl = dotenv.env['API_URL'];

  static const String apiKey = '';
}