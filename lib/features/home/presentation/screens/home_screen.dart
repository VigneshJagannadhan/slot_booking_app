import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_entity.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_bloc.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_events.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_state.dart';

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
    context.read<DoctorBloc>().add(LoadDoctors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SlotBooker', style: AppStyles.ts20CFFFFFFW600),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial || state is AuthFailure) {
                NavigationHelper.pushAndReplaceNamed(
                  context: context,
                  destination: RegisterScreen.route,
                );
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
                icon: const Icon(Icons.logout, color: Colors.white),
              );
            },
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            child: Text('Available Doctors', style: AppStyles.ts24C000W600),
          ),

          BlocBuilder<DoctorBloc, DoctorState>(
            builder: (context, state) {
              if (state is DoctorLoading) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state is DoctorLoaded) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: state.doctors.length,
                    itemBuilder:
                        (context, index) =>
                            DoctorCard(doctor: state.doctors[index]),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});

  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.r,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title: Text(doctor.name, style: AppStyles.ts14C000W600),
        subtitle: Text(doctor.hospitalOrClinic, style: AppStyles.ts12C000W400),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: Colors.grey,
        ),
      ),
    );
  }
}
