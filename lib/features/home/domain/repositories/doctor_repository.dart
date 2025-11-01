import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_list_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

abstract class DoctorRepository {
  Future<Either<Failure, DoctorListEntity>> getDoctors({int page = 1});
}
