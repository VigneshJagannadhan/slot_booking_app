import 'package:slot_booking_app/core/services/api_service.dart';
import 'package:slot_booking_app/utils/app_urls.dart';
import '../models/token_model.dart';

abstract class AuthRemoteDataSource {
  Future<TokenModel> login(String email, String password);
  Future<TokenModel> register(
    String name,
    String email,
    String password,
    bool isDoctor,
    String? hospital,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<TokenModel> login(String email, String password) async {
    final response = await client.post(
      AppUrls.login,
      data: {'email': email, 'password': password},
    );
    return TokenModel.fromJson(response.data);
  }

  @override
  Future<TokenModel> register(
    String name,
    String email,
    String password,
    bool isDoctor,
    String? hospital,
  ) async {
    final response = await client.post(
      AppUrls.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'isDoctor': isDoctor,
        'hospitalOrClinic': hospital,
      },
    );
    return TokenModel.fromJson(response.data);
  }
}
