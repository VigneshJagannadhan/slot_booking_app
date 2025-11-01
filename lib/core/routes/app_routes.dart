import 'package:flutter/material.dart';
import 'package:slot_booking_app/features/appointments/presentation/screens/appointments_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/features/home/presentation/screens/doctor_home_screen.dart';
import 'package:slot_booking_app/features/home/presentation/screens/user_home_screen.dart';

class AppRoutes {
  static getInitialRoute() {
    return SplashScreen.route;
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    SplashScreen.route: (context) => const SplashScreen(),
    AuthScreen.route: (context) => const AuthScreen(),
    HomeScreen.route: (context) => const HomeScreen(),
    DoctorHomeScreen.route: (context) => const DoctorHomeScreen(),
    UserHomeScreen.route: (context) => const UserHomeScreen(),
    AppointmentsScreen.route: (context) => const AppointmentsScreen(),
  };
}
