import 'package:slot_booking_app/features/auth/data/models/user_model.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';

class TokenModel {
  final String? token;
  final String? refreshToken;
  final UserModel? user;

  const TokenModel({this.token, this.refreshToken, this.user});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
      refreshToken: json['refreshToken'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'refreshToken': refreshToken,
    'user': user?.toJson(),
  };

  TokenEntity toDomain() => TokenEntity(
    token: token,
    refreshToken: refreshToken,
    user: user?.toDomain(),
  );
}
