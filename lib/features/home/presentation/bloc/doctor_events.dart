import 'package:equatable/equatable.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();
}

class LoadDoctors extends DoctorEvent {
  @override
  List<Object?> get props => [];
}

class LoadMoreDoctors extends DoctorEvent {
  @override
  List<Object?> get props => [];
}

class RefreshDoctors extends DoctorEvent {
  @override
  List<Object?> get props => [];
}
