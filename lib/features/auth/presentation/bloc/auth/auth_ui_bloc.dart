// presentation/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_ui_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_ui_state.dart';

class AuthUIBloc extends Bloc<AuthModeEvent, AuthModeState> {
  AuthUIBloc() : super(AuthModeLogin()) {
    on<AuthModeChanged>(_onAuthModeChanged);
  }
  void _onAuthModeChanged(AuthModeChanged event, Emitter<AuthModeState> emit) {
    if (state is AuthModeLogin) {
      emit(AuthModeRegister());
    } else {
      emit(AuthModeLogin());
    }
  }
}
