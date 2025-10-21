import 'package:slot_booking_app/features/auth/data/data_provider/auth_data_provider.dart';
import 'package:slot_booking_app/models/token_model.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider;
  AuthRepository({required this.authDataProvider});

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDataProvider.login(
        email: email,
        password: password,
      );
      if (response != null) {
        return TokenModel.fromJson(response);
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> register({
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
      if (response != null) {
        return TokenModel.fromJson(response);
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
