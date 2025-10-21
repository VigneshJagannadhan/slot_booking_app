import 'package:flutter/material.dart';
import 'package:slot_booking_app/utils/custom_snackbars.dart';

/// Helper class for easy snackbar usage throughout the app
class SnackbarHelper {
  /// Show success message with modern snackbar
  static void success(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    CustomSnackbars.showSuccess(
      context,
      message: message,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  /// Show error message with modern snackbar
  static void error(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    CustomSnackbars.showError(
      context,
      message: message,
      duration: duration ?? const Duration(seconds: 4),
    );
  }

  /// Common success messages
  static void loginSuccess(BuildContext context) {
    success(context, message: 'Login successful! Welcome back! 👋');
  }

  static void registrationSuccess(BuildContext context) {
    success(context, message: 'Registration successful! Welcome aboard! 🎉');
  }

  static void logoutSuccess(BuildContext context) {
    success(context, message: 'Logged out successfully! See you soon! 👋');
  }

  static void profileUpdated(BuildContext context) {
    success(context, message: 'Profile updated successfully! ✅');
  }

  static void slotBooked(BuildContext context) {
    success(context, message: 'Slot booked successfully! 🎯');
  }

  /// Common error messages
  static void networkError(BuildContext context) {
    error(context, message: 'Network error! Please check your connection 🌐');
  }

  static void invalidCredentials(BuildContext context) {
    error(context, message: 'Invalid email or password! Please try again 🔐');
  }

  static void emailAlreadyExists(BuildContext context) {
    error(
      context,
      message: 'Email already exists! Please use a different email 📧',
    );
  }

  static void serverError(BuildContext context) {
    error(context, message: 'Server error! Please try again later 🔧');
  }

  static void validationError(BuildContext context, {String? field}) {
    error(
      context,
      message:
          field != null
              ? 'Please enter a valid $field! 📝'
              : 'Please check your input and try again! 📝',
    );
  }
}
