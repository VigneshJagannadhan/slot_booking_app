import 'package:equatable/equatable.dart';

abstract class AuthModeState extends Equatable {
  const AuthModeState();
  @override
  List<Object?> get props => [];
}

class AuthModeLogin extends AuthModeState {}

class AuthModeRegister extends AuthModeState {}
