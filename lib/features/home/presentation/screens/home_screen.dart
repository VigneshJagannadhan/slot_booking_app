import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
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
          if (state is UserSuccess) {
            final user = state.user;
            // Check if user is a doctor
            final isDoctor =
                user.role?.toLowerCase() == 'doctor' || user.isDoctor == true;

            // Redirect based on role
            if (isDoctor) {
              NavigationHelper.pushAndReplaceNamed(
                context: context,
                destination: DoctorHomeScreen.route,
              );
            } else {
              NavigationHelper.pushAndReplaceNamed(
                context: context,
                destination: UserHomeScreen.route,
              );
            }
          } else if (state is UserFailure) {
            // Handle error state if needed
            // For now, redirect to user home as fallback
            NavigationHelper.pushAndReplaceNamed(
              context: context,
              destination: UserHomeScreen.route,
            );
          }
        },
        builder: (context, state) {
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
