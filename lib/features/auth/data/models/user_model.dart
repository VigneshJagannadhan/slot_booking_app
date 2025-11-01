import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';

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

  UserEntity toDomain() => UserEntity(
    id: id,
    name: name,
    email: email,
    role: role,
    isDoctor: isDoctor,
    hospitalOrClinic: hospitalOrClinic,
  );
}
