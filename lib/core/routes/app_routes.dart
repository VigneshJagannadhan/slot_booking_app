import 'package:flutter/material.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/splash_screen.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';

class AppRoutes {
  static getInitialRoute() {
    return SplashScreen.route;
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    SplashScreen.route: (context) => const SplashScreen(),
    RegisterScreen.route: (context) => const RegisterScreen(),
    HomeScreen.route: (context) => const HomeScreen(),
  };
}
