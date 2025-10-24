import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';

class TokenDto {
  final String token;

  const TokenDto({required this.token});

  factory TokenDto.fromJson(Map<String, dynamic> json) =>
      TokenDto(token: json['token'] as String);

  Map<String, dynamic> toJson() => {'token': token};

  Token toDomain() => Token(token: token);
}
