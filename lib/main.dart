import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:slot_booking_app/features/auth/presentation/splash_screen.dart';
import 'package:slot_booking_app/core/helpers/shared_preferences_helper.dart';
import 'package:slot_booking_app/core/utils/app_blocs.dart';
import 'package:slot_booking_app/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SharedPreferencesHelper.init();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder:
          (context, child) => MultiBlocProvider(
            providers: getAppBlocs(),
            child: MaterialApp(
              title: 'Slot Booking App',
              theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            ),
          ),
    );
  }
}
