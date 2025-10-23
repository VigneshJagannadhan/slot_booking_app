import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/models/token_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginEvent>(_login);
    on<AuthRegisterEvent>(_register);
    on<AuthLogoutEvent>(_logout);
  }

  _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final TokenModel token = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(token: token));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  _register(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final TokenModel token = await authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(token: token));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  _logout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
