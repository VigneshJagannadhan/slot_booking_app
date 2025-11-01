import 'package:slot_booking_app/features/appointments/data/models/appointment_model.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_list_entity.dart';

class AppointmentListModel {
  final List<AppointmentModel> appointments;
  final int currentPage;
  final int totalPages;
  final int totalAppointments;
  final bool hasNextPage;
  final bool hasPrevPage;

  AppointmentListModel({
    required this.appointments,
    required this.currentPage,
    required this.totalPages,
    required this.totalAppointments,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory AppointmentListModel.fromJson(Map<String, dynamic> json) {
    return AppointmentListModel(
      appointments:
          (json['appointments'] as List<dynamic>?)
              ?.map(
                (appointmentJson) => AppointmentModel.fromJson(appointmentJson),
              )
              .toList() ??
          [],
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalAppointments: json['totalAppointments'] ?? 0,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }

  AppointmentListEntity toDomain() {
    return AppointmentListEntity(
      appointments: appointments.map((dto) => dto.toDomain()).toList(),
      currentPage: currentPage,
      totalPages: totalPages,
      totalAppointments: totalAppointments,
      hasNextPage: hasNextPage,
      hasPrevPage: hasPrevPage,
    );
  }
}
