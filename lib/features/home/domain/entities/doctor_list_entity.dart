import 'package:slot_booking_app/features/home/domain/entities/doctor_entity.dart';

class DoctorListEntity {
  final List<DoctorEntity> doctors;
  final int currentPage;
  final int totalPages;
  final int totalDoctors;
  final bool hasNextPage;
  final bool hasPrevPage;

  const DoctorListEntity({
    required this.doctors,
    required this.currentPage,
    required this.totalPages,
    required this.totalDoctors,
    required this.hasNextPage,
    required this.hasPrevPage,
  });
}
