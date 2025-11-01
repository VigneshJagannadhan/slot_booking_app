import 'package:slot_booking_app/core/services/api_service.dart';
import 'package:slot_booking_app/features/auth/data/models/user_model.dart';
import 'package:slot_booking_app/utils/app_urls.dart';
import '../models/token_model.dart';

abstract class AuthDataSource {
  Future<TokenModel> login(String email, String password);
  Future<TokenModel> register(
    String name,
    String email,
    String password,
    bool isDoctor,
    String? hospital,
    String? designation,
  );
  Future<UserModel> getUser();
}

class AuthDataSourceImpl implements AuthDataSource {
  final ApiClient client;
  AuthDataSourceImpl(this.client);

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
    String? designation,
  ) async {
    final response = await client.post(
      AppUrls.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'isDoctor': isDoctor,
        if (hospital != null) 'hospitalOrClinic': hospital,
        if (designation != null) 'designation': designation,
      },
    );
    return TokenModel.fromJson(response.data);
  }

  @override
  Future<UserModel> getUser() async {
    final response = await client.get(AppUrls.userProfile);
    return UserModel.fromJson(response.data);
  }
}
