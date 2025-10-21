import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/features/auth/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/data/data_provider/auth_data_provider.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/login_screen.dart';
import 'package:slot_booking_app/helpers/shared_preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
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
            providers: [
              BlocProvider(
                create:
                    (context) => AuthBloc(
                      authRepository: AuthRepository(
                        authDataProvider: AuthDataProvider(),
                      ),
                    ),
              ),
            ],
            child: MaterialApp(
              title: 'Slot Booking App',
              theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
              home: AuthScreen(),
              debugShowCheckedModeBanner: false,
            ),
          ),
    );
  }
}
