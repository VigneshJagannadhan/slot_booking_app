import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';

class TokenModel {
  final String token;
  final String refreshToken;
  final UserDto user;

  const TokenModel({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
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
  final bool isDoctor;
  final String hospitalOrClinic;

  const UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isDoctor,
    required this.hospitalOrClinic,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    role: json['role'] as String,
    isDoctor: json['isDoctor'] as bool,
    hospitalOrClinic: json['hospitalOrClinic'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
    'isDoctor': isDoctor,
    'hospitalOrClinic': hospitalOrClinic,
  };

  User toDomain() => User(
    id: id,
    name: name,
    email: email,
    role: role,
    isDoctor: isDoctor,
    hospitalOrClinic: hospitalOrClinic,
  );
}
