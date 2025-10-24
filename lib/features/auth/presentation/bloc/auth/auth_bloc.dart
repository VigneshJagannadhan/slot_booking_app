// presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase login;
  final RegisterUseCase register;

  AuthBloc({required this.login, required this.register})
    : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await login(e.email, e.password);
    result.fold(
      (f) => emit(AuthFailure(f)),
      (token) => emit(AuthSuccess(token)),
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await register(e.name, e.email, e.password);
    result.fold(
      (f) => emit(AuthFailure(f)),
      (token) => emit(AuthSuccess(token)),
    );
  }
}
