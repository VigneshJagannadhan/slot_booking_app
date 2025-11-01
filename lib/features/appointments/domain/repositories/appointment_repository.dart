import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_list_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, AppointmentListEntity>> getAppointments({
    int page = 1,
  });
  Future<Either<Failure, AppointmentEntity>> createAppointment({
    required AppointmentEntity appointment,
  });
  Future<Either<Failure, AppointmentEntity>> updateAppointment({
    required AppointmentEntity appointment,
  });
  Future<Either<Failure, AppointmentEntity>> deleteAppointment({
    required String id,
  });
}
