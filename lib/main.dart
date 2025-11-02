import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slot_booking_app/core/helpers/app_lifecycle_helper.dart';
import 'package:slot_booking_app/core/routes/app_routes.dart';
import 'package:slot_booking_app/core/helpers/shared_preferences_helper.dart';
import 'package:slot_booking_app/utils/app_blocs.dart';
import 'package:slot_booking_app/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SharedPreferencesHelper.init();
  AppLifecycleObserver().init();
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
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                textTheme: GoogleFonts.montserratTextTheme(),
                primaryTextTheme: GoogleFonts.montserratTextTheme(),
              ),
              initialRoute: AppRoutes.getInitialRoute(),
              routes: AppRoutes.routes,
              debugShowCheckedModeBanner: false,
            ),
          ),
    );
  }
}
