import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';

class TokenDto {
  final String token;
  final String refreshToken;
  final UserDto user;

  const TokenDto({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return TokenDto(
      token: data['token'] as String,
      refreshToken: data['refreshToken'] as String,
      user: UserDto.fromJson(data['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'refreshToken': refreshToken,
    'user': user.toJson(),
  };

  Token toDomain() =>
      Token(token: token, refreshToken: refreshToken, user: user.toDomain());
}

class UserDto {
  final String id;
  final String name;
  final String email;
  final String role;

  const UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    role: json['role'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
  };

  User toDomain() => User(id: id, name: name, email: email, role: role);
}
