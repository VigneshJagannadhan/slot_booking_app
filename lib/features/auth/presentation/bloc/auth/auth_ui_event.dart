import 'package:equatable/equatable.dart';

abstract class AuthModeEvent extends Equatable {
  const AuthModeEvent();
  @override
  List<Object?> get props => [];
}

class AuthModeChanged extends AuthModeEvent {}
