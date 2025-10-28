import 'package:equatable/equatable.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_entity.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();
}

class DoctorInitial extends DoctorState {
  @override
  List<Object?> get props => [];
}

class DoctorLoading extends DoctorState {
  @override
  List<Object?> get props => [];
}

class DoctorLoaded extends DoctorState {
  final List<Doctor> doctors;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  const DoctorLoaded({
    required this.doctors,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  @override
  List<Object?> get props => [
    doctors,
    currentPage,
    totalPages,
    hasNextPage,
    hasPrevPage,
  ];
}

class DoctorLoadingMore extends DoctorState {
  final List<Doctor> doctors;

  const DoctorLoadingMore(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class DoctorFailure extends DoctorState {
  final String message;

  const DoctorFailure(this.message);

  @override
  List<Object?> get props => [message];
}
