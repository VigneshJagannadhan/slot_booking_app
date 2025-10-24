import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/login_screen.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/core/helpers/shared_preferences_helper.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = SharedPreferencesHelper.getUserToken();

      Future.delayed(const Duration(seconds: 2), () {
        if (token != null && token.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          return;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SlotBooker", style: AppStyles.ts28C000W400),
            SizedBox(height: 20.h),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
