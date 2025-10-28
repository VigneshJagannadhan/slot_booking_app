import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/core/di/service_locator.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_bloc.dart';

getAppBlocs() => [
  BlocProvider(create: (context) => sl<AuthBloc>()),
  BlocProvider(create: (context) => sl<DoctorBloc>()),
];
