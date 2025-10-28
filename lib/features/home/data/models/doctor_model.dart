import 'package:slot_booking_app/features/home/domain/entities/doctor_entity.dart';

class DoctorDto {
  final String id;
  final String name;
  final String hospitalOrClinic;
  final String createdAt;
  final String updatedAt;

  DoctorDto({
    required this.id,
    required this.name,
    required this.hospitalOrClinic,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      hospitalOrClinic: json['hospitalOrClinic'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Doctor toDomain() {
    return Doctor(
      id: id,
      name: name,
      hospitalOrClinic: hospitalOrClinic,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}
