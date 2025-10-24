import 'package:equatable/equatable.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/core/utils/app_exceptions.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Token token;
  const AuthSuccess(this.token);
  @override
  List<Object?> get props => [token];
}

class AuthFailure extends AuthState {
  final Failure failure;
  const AuthFailure(this.failure);
  @override
  List<Object?> get props => [failure];
}
