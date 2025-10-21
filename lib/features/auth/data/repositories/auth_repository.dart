import 'package:slot_booking_app/features/auth/data/data_provider/auth_data_provider.dart';
import 'package:slot_booking_app/helpers/shared_preferences_helper.dart';
import 'package:slot_booking_app/models/token_model.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider;
  AuthRepository({required this.authDataProvider});

  Future<TokenModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDataProvider.login(
        email: email,
        password: password,
      );

      if (response.isEmpty) {
        throw Exception('Login failed: No response received');
      }

      final tokenModel = TokenModel.fromJson(response);
      await SharedPreferencesHelper.setUserToken(tokenModel.token);

      return tokenModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<TokenModel> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await authDataProvider.register(
        name: name,
        email: email,
        password: password,
      );

      if (response.isEmpty) {
        throw Exception('Registration failed: No response received');
      }

      final tokenModel = TokenModel.fromJson(response);
      await SharedPreferencesHelper.setUserToken(tokenModel.token);

      return tokenModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await SharedPreferencesHelper.clearUserToken();
    } catch (e) {
      rethrow;
    }
  }
}
