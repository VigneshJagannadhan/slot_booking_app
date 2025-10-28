import 'package:slot_booking_app/features/home/domain/entities/doctor_entity.dart';

class DoctorList {
  final List<Doctor> doctors;
  final int currentPage;
  final int totalPages;
  final int totalDoctors;
  final bool hasNextPage;
  final bool hasPrevPage;

  const DoctorList({
    required this.doctors,
    required this.currentPage,
    required this.totalPages,
    required this.totalDoctors,
    required this.hasNextPage,
    required this.hasPrevPage,
  });
}
