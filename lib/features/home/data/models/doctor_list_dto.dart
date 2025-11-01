import 'package:slot_booking_app/features/home/data/models/doctor_model.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_list_entity.dart';

class DoctorListDto {
  final List<DoctorDto> doctors;
  final int currentPage;
  final int totalPages;
  final int totalDoctors;
  final bool hasNextPage;
  final bool hasPrevPage;

  DoctorListDto({
    required this.doctors,
    required this.currentPage,
    required this.totalPages,
    required this.totalDoctors,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory DoctorListDto.fromJson(Map<String, dynamic> json) {
    return DoctorListDto(
      doctors:
          (json['doctors'] as List<dynamic>?)
              ?.map((doctorJson) => DoctorDto.fromJson(doctorJson))
              .toList() ??
          [],
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalDoctors: json['totalDoctors'] ?? 0,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }

  DoctorListEntity toDomain() {
    return DoctorListEntity(
      doctors: doctors.map((dto) => dto.toDomain()).toList(),
      currentPage: currentPage,
      totalPages: totalPages,
      totalDoctors: totalDoctors,
      hasNextPage: hasNextPage,
      hasPrevPage: hasPrevPage,
    );
  }
}
