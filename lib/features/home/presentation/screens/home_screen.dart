import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/login_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';

class HomeScreen extends StatelessWidget {
  static const String route = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Home', style: AppStyles.ts24C000W600),
            SizedBox(height: 20.h),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthInitial || state is AuthFailure) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                  label: 'Logout',
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
