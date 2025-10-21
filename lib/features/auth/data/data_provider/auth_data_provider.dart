import 'package:dio/dio.dart';
import 'package:slot_booking_app/services/api_service.dart';
import 'package:slot_booking_app/utils/app_urls.dart';

class AuthDataProvider {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await APIService().postDataFromDio(
        endPoint: AppUrls.login,
        payload: {'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response!.data['message'] ?? 'Login failed');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await APIService().postDataFromDio(
        endPoint: AppUrls.register,
        payload: {'email': email, 'password': password, 'name': name},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response!.data['message'] ?? 'Registration failed');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }
}
