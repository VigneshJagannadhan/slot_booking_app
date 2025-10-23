import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
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
            PrimaryButton(
              label: 'Logout',
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
