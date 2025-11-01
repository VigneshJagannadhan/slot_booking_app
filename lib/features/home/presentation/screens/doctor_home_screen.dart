import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/gradient_background.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/doctor_dashboard_item.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/rounded_shadow_container.dart';

class DoctorHomeScreen extends StatefulWidget {
  static const String route = 'doctor_home';
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 70.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      String? userName;
                      if (state is UserSuccess) {
                        userName = state.user.name ?? '';
                      }

                      return Row(
                        children: [
                          CircleAvatar(radius: 20.r),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome,',
                                style: AppStyles.ts12CFFFFFFW400,
                              ),
                              Text(
                                userName ?? '',
                                style: AppStyles.ts14CFFFFFFW600,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthInitial || state is AuthFailure) {
                        NavigationHelper.pushAndReplaceNamed(
                          context: context,
                          destination: AuthScreen.route,
                        );
                      }
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutRequested());
                        },
                        icon: const Icon(Icons.settings, color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),

            DoctorDashboard(),

            Column(
              children: [
                PrimaryButton(onPressed: () {}, label: 'Manage Appointments'),
                SizedBox(height: 10.h),
                PrimaryButton(onPressed: () {}, label: 'Set Available Slots'),
                SizedBox(height: 20.h),
              ],
            ),

            AppointmentsSection(),
          ],
        ),
      ),
    );
  }
}

class AppointmentsSection extends StatelessWidget {
  const AppointmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Next Appointment', style: AppStyles.ts24CFFFFFFW600),
        SizedBox(height: 10.h),
        AppointmentItem(),
      ],
    );
  }
}

class AppointmentItem extends StatelessWidget {
  const AppointmentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: RoundedContainerWithShadow(
        padding: EdgeInsets.all(15.r),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 25.r),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jake Williams", style: AppStyles.ts14C000W600),

                    Text("10:00 am - 10:30 am", style: AppStyles.ts12C000W400),

                    Text(
                      "Reason : Consultation",
                      style: AppStyles.ts12C000W400,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    color: Colors.red,
                    onPressed: () {},
                    label: "Cancel",
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: PrimaryButton(onPressed: () {}, label: "Start"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text('Doctor Dashboard', style: AppStyles.ts24CFFFFFFW600),
        SizedBox(height: 10.h),
        Column(
          children: [
            DoctorDashBoardItem(header: 'Total Appointments today', count: 15),
            SizedBox(height: 10.h),
            DoctorDashBoardItem(header: 'Pending Appointments', count: 12),
            SizedBox(height: 10.h),
            DoctorDashBoardItem(header: 'Completed Appointments', count: 3),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
