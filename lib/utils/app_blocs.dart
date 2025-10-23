import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/features/auth/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/bloc/visibility/visibility_bloc.dart';
import 'package:slot_booking_app/features/auth/data/data_provider/auth_data_provider.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';

getAppBlocs() => [
  BlocProvider(
    create:
        (context) => AuthBloc(
          authRepository: AuthRepository(authDataProvider: AuthDataProvider()),
        ),
  ),
  BlocProvider(create: (context) => VisibilityBloc()),
];
