import 'package:flutter/material.dart';
import 'package:slot_booking_app/utils/snackbar_helper.dart';

/// Demo class showing how to use the custom snackbars
/// This file can be deleted after you understand the usage
class SnackbarDemo extends StatelessWidget {
  const SnackbarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Snackbar Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Success Examples
            const Text(
              'Success Snackbars:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => SnackbarHelper.loginSuccess(context),
              child: const Text('Login Success'),
            ),

            ElevatedButton(
              onPressed: () => SnackbarHelper.registrationSuccess(context),
              child: const Text('Registration Success'),
            ),

            ElevatedButton(
              onPressed: () => SnackbarHelper.slotBooked(context),
              child: const Text('Slot Booked'),
            ),

            ElevatedButton(
              onPressed:
                  () => SnackbarHelper.success(
                    context,
                    message: 'Custom success message! 🎉',
                  ),
              child: const Text('Custom Success'),
            ),

            const SizedBox(height: 30),

            // Error Examples
            const Text(
              'Error Snackbars:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => SnackbarHelper.networkError(context),
              child: const Text('Network Error'),
            ),

            ElevatedButton(
              onPressed: () => SnackbarHelper.invalidCredentials(context),
              child: const Text('Invalid Credentials'),
            ),

            ElevatedButton(
              onPressed: () => SnackbarHelper.serverError(context),
              child: const Text('Server Error'),
            ),

            ElevatedButton(
              onPressed:
                  () => SnackbarHelper.error(
                    context,
                    message: 'Custom error message! ❌',
                  ),
              child: const Text('Custom Error'),
            ),
          ],
        ),
      ),
    );
  }
}
