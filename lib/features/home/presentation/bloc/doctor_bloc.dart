import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/features/home/domain/usecases/get_doctors_usecase.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_events.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctorsUseCase getDoctorsUseCase;

  DoctorBloc({required this.getDoctorsUseCase}) : super(DoctorInitial()) {
    on<LoadDoctors>(_onLoadDoctors);
    on<LoadMoreDoctors>(_onLoadMoreDoctors);
    on<RefreshDoctors>(_onRefreshDoctors);
  }

  Future<void> _onLoadDoctors(
    LoadDoctors event,
    Emitter<DoctorState> emit,
  ) async {
    emit(DoctorLoading());

    final result = await getDoctorsUseCase(page: 1);
    result.fold(
      (failure) => emit(DoctorFailure(failure.message)),
      (doctorList) => emit(
        DoctorLoaded(
          doctors: doctorList.doctors,
          currentPage: doctorList.currentPage,
          totalPages: doctorList.totalPages,
          hasNextPage: doctorList.hasNextPage,
          hasPrevPage: doctorList.hasPrevPage,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreDoctors(
    LoadMoreDoctors event,
    Emitter<DoctorState> emit,
  ) async {
    if (state is DoctorLoaded) {
      final currentState = state as DoctorLoaded;
      if (!currentState.hasNextPage) return;

      emit(DoctorLoadingMore(currentState.doctors));

      final result = await getDoctorsUseCase(
        page: currentState.currentPage + 1,
      );
      result.fold(
        (failure) => emit(DoctorFailure(failure.message)),
        (doctorList) => emit(
          DoctorLoaded(
            doctors: [...currentState.doctors, ...doctorList.doctors],
            currentPage: doctorList.currentPage,
            totalPages: doctorList.totalPages,
            hasNextPage: doctorList.hasNextPage,
            hasPrevPage: doctorList.hasPrevPage,
          ),
        ),
      );
    }
  }

  Future<void> _onRefreshDoctors(
    RefreshDoctors event,
    Emitter<DoctorState> emit,
  ) async {
    add(LoadDoctors());
  }
}
