import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/gradient_background.dart';
import 'package:slot_booking_app/features/home/presentation/screens/home_screen.dart';
import 'package:slot_booking_app/core/helpers/shared_preferences_helper.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';

class SplashScreen extends StatefulWidget {
  static const String route = 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await SharedPreferencesHelper.getUserToken();

      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;

        if (token != null && token.isNotEmpty) {
          NavigationHelper.pushAndReplaceNamed(
            context: context,
            destination: HomeScreen.route,
          );
          return;
        } else {
          NavigationHelper.pushAndReplaceNamed(
            context: context,
            destination: AuthScreen.route,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("MediBook", style: AppStyles.ts28CFFFFFFW400),
              SizedBox(height: 20.h),
              CupertinoActivityIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
