import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static String baseUrl =
      dotenv.env['BASE_URL'] ?? "http://localhost:8080/api/";
  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
  static const String doctors = 'user/doctors';
  static const String userProfile = 'user/profile';
  static const String appointments = 'doctor/appointments';
}
