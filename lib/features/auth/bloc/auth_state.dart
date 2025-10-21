part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final TokenModel token;
  AuthSuccess({required this.token});
}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}
