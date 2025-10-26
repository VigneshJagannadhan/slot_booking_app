import 'package:flutter/material.dart';
import 'package:slot_booking_app/core/helpers/shared_preferences_helper.dart';

class NavigationHelper {
  static void pushAndReplaceNamed({
    required BuildContext context,
    required String destination,
  }) {
    Navigator.pushReplacementNamed(context, destination);
    SharedPreferencesHelper.setUserRoute(destination.toString());
  }

  static void pushNamed({
    required BuildContext context,
    required String destination,
  }) {
    Navigator.pushNamed(context, destination);
    SharedPreferencesHelper.setUserRoute(destination.toString());
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
    final route = ModalRoute.of(context)?.settings.name;
    if (route != null) {
      SharedPreferencesHelper.setUserRoute(route);
    }
  }
}
