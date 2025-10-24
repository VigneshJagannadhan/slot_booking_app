import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static String baseUrl = dotenv.env['BASE_URL'] ?? "";
  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
}
