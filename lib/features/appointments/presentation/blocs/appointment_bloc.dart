import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/features/appointments/domain/usecases/appointment_usecase.dart';
import 'package:slot_booking_app/features/appointments/presentation/blocs/appointment_events.dart';
import 'package:slot_booking_app/features/appointments/presentation/blocs/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvents, AppointmentState> {
  GetAppointmentUsecase appointmentUsecase;
  CreateAppointmentUsecase createAppointmentUsecase;
  UpdateAppointmentUsecase updateAppointmentUsecase;
  DeleteAppointmentUsecase deleteAppointmentUsecase;

  AppointmentBloc({
    required this.appointmentUsecase,
    required this.createAppointmentUsecase,
    required this.updateAppointmentUsecase,
    required this.deleteAppointmentUsecase,
  }) : super(AppointmentInitial()) {
    on<LoadAppointment>(_fetchAppointments);
    on<CreateAppointment>(_createAppointment);
    on<UpdateAppointment>(_updateAppointment);
    on<DeleteAppointment>(_deleteAppointment);
  }

  Future<void> _fetchAppointments(
    LoadAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(AppointmentLoading());

    final result = await appointmentUsecase.call(page: 1);

    result.fold(
      (failure) => emit(AppointmentFailure(message: failure.message)),
      (appointmentList) => emit(
        AppointmentsLoaded(
          appointments: appointmentList.appointments,
          currentPage: appointmentList.currentPage,
          totalPages: appointmentList.totalPages,
          hasNextPage: appointmentList.hasNextPage,
          hasPrevPage: appointmentList.hasPrevPage,
        ),
      ),
    );
  }

  Future<void> _createAppointment(
    CreateAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(AppointmentLoading());

    final result = await createAppointmentUsecase.call(
      appointment: event.appointment,
    );

    result.fold(
      (failure) => emit(AppointmentFailure(message: failure.message)),
      (appointment) => emit(AppointmentCreated(appointment: appointment)),
    );
  }

  Future<void> _updateAppointment(
    UpdateAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(AppointmentLoading());

    final result = await updateAppointmentUsecase.call(
      appointment: event.appointment,
    );

    result.fold(
      (failure) => emit(AppointmentFailure(message: failure.message)),
      (appointment) => emit(AppointmentUpdated(appointment: appointment)),
    );
  }

  Future<void> _deleteAppointment(
    DeleteAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(AppointmentLoading());

    final result = await deleteAppointmentUsecase.call(id: event.id);

    result.fold(
      (failure) => emit(AppointmentFailure(message: failure.message)),
      (appointment) => emit(AppointmentDeleted(id: event.id)),
    );
  }
}
