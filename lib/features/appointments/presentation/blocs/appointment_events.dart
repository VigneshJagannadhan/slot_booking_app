import 'package:equatable/equatable.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';

class AppointmentEvents extends Equatable {
  const AppointmentEvents();

  @override
  List<Object?> get props => [];
}

class LoadAppointment extends AppointmentEvents {}

class CreateAppointment extends AppointmentEvents {
  final AppointmentEntity appointment;

  const CreateAppointment({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class UpdateAppointment extends AppointmentEvents {
  final AppointmentEntity appointment;

  const UpdateAppointment({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class DeleteAppointment extends AppointmentEvents {
  final String id;

  const DeleteAppointment({required this.id});

  @override
  List<Object?> get props => [id];
}
