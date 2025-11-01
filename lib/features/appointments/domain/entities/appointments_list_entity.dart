import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';

class AppointmentListEntity {
  final List<AppointmentEntity> appointments;
  final int currentPage;
  final int totalPages;
  final int totalAppointments;
  final bool hasNextPage;
  final bool hasPrevPage;

  const AppointmentListEntity({
    required this.appointments,
    required this.currentPage,
    required this.totalPages,
    required this.totalAppointments,
    required this.hasNextPage,
    required this.hasPrevPage,
  });
}
