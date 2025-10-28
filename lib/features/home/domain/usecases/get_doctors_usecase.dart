import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/home/data/repositories/doctor_repository.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_list_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class GetDoctorsUseCase {
  final DoctorRepository repository;

  GetDoctorsUseCase(this.repository);

  Future<Either<Failure, DoctorList>> call({int page = 1}) async {
    return await repository.getDoctors(page: page);
  }
}
