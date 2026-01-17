import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoint {
  final mapKey = dotenv.env['MAP_KEY'];

  final apiUrl = dotenv.env['API_URL'];

  static const String apiKey = 'AIzaSyChTmxG_4Md8-X8eXMSN6TrQ5-HtcKk-OE';
}