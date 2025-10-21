import 'package:dio/dio.dart';
import 'package:slot_booking_app/services/api_service.dart';
import 'package:slot_booking_app/utils/app_urls.dart';

class AuthDataProvider {
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await APIService().postDataFromDio(
        endPoint: AppUrls.login,
        payload: {'email': email, 'password': password},
      );
      return response.data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await APIService().postDataFromDio(
        endPoint: AppUrls.register,
        payload: {'email': email, 'password': password, 'name': name},
      );
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'An error occurred';
    } catch (e) {
      throw e.toString();
    }
  }
}
