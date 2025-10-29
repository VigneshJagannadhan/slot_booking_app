// presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/core/helpers/shared_preferences_helper.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserUseCase getUser;
  final LoginUseCase login;
  final RegisterUseCase register;

  AuthBloc({required this.login, required this.register, required this.getUser})
    : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_logout);
    on<GetUserRequested>(_onGetUserRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await login(e.email, e.password);
    result.fold((f) => emit(AuthFailure(f)), (token) async {
      emit(AuthSuccess(token));
      if (token.token != null) {
        await SharedPreferencesHelper.setUserToken(token.token!);
      }
    });
  }

  Future<void> _onRegisterRequested(
    RegisterRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await register(
      e.name,
      e.email,
      e.password,
      e.isDoctor,
      e.hospital,
      e.designation,
    );
    result.fold((f) => emit(AuthFailure(f)), (token) async {
      emit(AuthSuccess(token));
      if (token.token != null) {
        await SharedPreferencesHelper.setUserToken(token.token!);
      }
    });
  }

  Future<void> _logout(LogoutRequested e, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    await SharedPreferencesHelper.clearUserToken();
    await SharedPreferencesHelper.clearUserRoute();
  }

  Future<void> _onGetUserRequested(
    GetUserRequested e,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await getUser();
    result.fold((f) => emit(UserFailure(f)), (user) => emit(UserSuccess(user)));
  }
}
