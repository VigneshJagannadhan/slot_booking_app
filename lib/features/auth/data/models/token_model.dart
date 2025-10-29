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

  Token toDomain() =>
      Token(token: token, refreshToken: refreshToken, user: user?.toDomain());
}

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final bool? isDoctor;
  final String? hospitalOrClinic;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isDoctor,
    this.hospitalOrClinic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    role: json['role'],
    isDoctor: json['isDoctor'],
    hospitalOrClinic: json['hospitalOrClinic'],
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
