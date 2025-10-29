import 'package:slot_booking_app/features/home/domain/entities/doctor_entity.dart';

class DoctorDto {
  final String? id;
  final String? name;
  final String? hospitalOrClinic;
  final num? rating;
  final String? designation;
  final String? createdAt;
  final String? updatedAt;

  DoctorDto({
    this.id,
    this.name,
    this.hospitalOrClinic,
    this.rating,
    this.designation,
    this.createdAt,
    this.updatedAt,
  });

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto(
      id: json['id'],
      name: json['name'],
      hospitalOrClinic: json['hospitalOrClinic'],
      designation: json['designation'],
      rating: json['rating'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Doctor toDomain() {
    return Doctor(
      id: id,
      name: name,
      hospitalOrClinic: hospitalOrClinic,
      designation: designation,
      rating: rating,
      createdAt: DateTime.parse(createdAt ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(updatedAt ?? DateTime.now().toString()),
    );
  }
}
