import 'package:equatable/equatable.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';

class AppointmentState extends Equatable {
  const AppointmentState();
  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentsLoaded extends AppointmentState {
  final List<Appointment> appointments;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  const AppointmentsLoaded({
    required this.appointments,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  @override
  List<Object?> get props => [
    appointments,
    currentPage,
    totalPages,
    hasNextPage,
    hasPrevPage,
  ];
}

class AppointmentLoading extends AppointmentState {}

class AppointmentFailure extends AppointmentState {
  final String message;

  const AppointmentFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AppointmentCreated extends AppointmentState {
  final Appointment appointment;

  const AppointmentCreated({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentUpdated extends AppointmentState {
  final Appointment appointment;

  const AppointmentUpdated({required this.appointment});

  @override
  List<Object?> get props => [appointment];
}

class AppointmentDeleted extends AppointmentState {
  final String id;

  const AppointmentDeleted({required this.id});

  @override
  List<Object?> get props => [id];
}
