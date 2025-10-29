import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/features/home/presentation/screens/doctor_home_screen.dart';
import 'package:slot_booking_app/features/home/presentation/screens/user_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    var authBloc = context.read<AuthBloc>();
    authBloc.add(GetUserRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial || state is AuthFailure) {
            NavigationHelper.pushAndReplaceNamed(
              context: context,
              destination: RegisterScreen.route,
            );
          }
        },
        builder: (context, state) {
          if (state is UserSuccess) {
            final user = state.user;
            final isDoctor =
                user.role?.toLowerCase() == 'doctor' || user.isDoctor == true;

            return isDoctor ? const DoctorHomeScreen() : const UserHomeScreen();
          }

          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
