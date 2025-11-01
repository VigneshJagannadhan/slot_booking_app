import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';

class TokenEntity {
  final String? token;
  final String? refreshToken;
  final UserEntity? user;

  const TokenEntity({this.token, this.refreshToken, this.user});
}
