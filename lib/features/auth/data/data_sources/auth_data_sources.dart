import 'package:slot_booking_app/core/services/api_service.dart';
import 'package:slot_booking_app/core/utils/app_urls.dart';
import '../models/token_dto.dart';

abstract class AuthRemoteDataSource {
  Future<TokenDto> login(String email, String password);
  Future<TokenDto> register(String name, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<TokenDto> login(String email, String password) async {
    final response = await client.post(
      AppUrls.login,
      data: {'email': email, 'password': password},
    );
    return TokenDto.fromJson(response.data);
  }

  @override
  Future<TokenDto> register(String name, String email, String password) async {
    final response = await client.post(
      AppUrls.register,
      data: {'name': name, 'email': email, 'password': password},
    );
    return TokenDto.fromJson(response.data);
  }
}
