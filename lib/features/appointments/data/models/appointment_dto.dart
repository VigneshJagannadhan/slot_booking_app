import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';

class AppointmentDto {
  final String? id;
  final String? name;
  final String? phone;
  final String? startAt;
  final String? createdAt;
  final String? updatedAt;

  AppointmentDto({
    this.id,
    this.name,
    this.phone,
    this.startAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AppointmentDto.fromJson(Map<String, dynamic> json) {
    return AppointmentDto(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      startAt: json['startAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'startAt': startAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Appointment toDomain() {
    return Appointment(
      id: id,
      name: name,
      phone: phone,
      startAt: startAt != null ? DateTime.parse(startAt!) : null,
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }

  static AppointmentDto fromDomain(Appointment appointment) {
    return AppointmentDto(
      id: appointment.id,
      name: appointment.name,
      phone: appointment.phone,
      startAt: appointment.startAt?.toIso8601String(),
      createdAt: appointment.createdAt?.toIso8601String(),
      updatedAt: appointment.updatedAt?.toIso8601String(),
    );
  }
}
