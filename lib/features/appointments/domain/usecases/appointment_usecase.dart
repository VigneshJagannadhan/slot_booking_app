import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_list_entity.dart';
import 'package:slot_booking_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class GetAppointmentUsecase {
  final AppointmentRepository appointmentRepository;
  GetAppointmentUsecase({required this.appointmentRepository});

  Future<Either<Failure, AppointmentListEntity>> call({int page = 1}) async {
    return await appointmentRepository.getAppointments(page: page);
  }
}

class CreateAppointmentUsecase {
  final AppointmentRepository appointmentRepository;
  CreateAppointmentUsecase({required this.appointmentRepository});

  Future<Either<Failure, AppointmentEntity>> call({
    required AppointmentEntity appointment,
  }) async {
    return await appointmentRepository.createAppointment(
      appointment: appointment,
    );
  }
}

class UpdateAppointmentUsecase {
  final AppointmentRepository appointmentRepository;
  UpdateAppointmentUsecase({required this.appointmentRepository});

  Future<Either<Failure, AppointmentEntity>> call({
    required AppointmentEntity appointment,
  }) async {
    return await appointmentRepository.updateAppointment(
      appointment: appointment,
    );
  }
}

class DeleteAppointmentUsecase {
  final AppointmentRepository appointmentRepository;
  DeleteAppointmentUsecase({required this.appointmentRepository});

  Future<Either<Failure, AppointmentEntity>> call({required String id}) async {
    return await appointmentRepository.deleteAppointment(id: id);
  }
}
