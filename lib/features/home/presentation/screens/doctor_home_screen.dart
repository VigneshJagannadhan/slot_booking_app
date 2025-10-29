import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';

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
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String userName = 'Doctor';
            String initials = 'D';
            if (state is UserSuccess) {
              userName = state.user.name ?? 'Doctor';
              initials =
                  userName.isNotEmpty
                      ? userName
                          .split(' ')
                          .map((n) => n[0])
                          .take(2)
                          .join()
                          .toUpperCase()
                      : 'D';
            }

            return Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  child: Text(initials, style: AppStyles.ts14C000W400),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome,', style: AppStyles.ts12C000W400),
                    Text(userName, style: AppStyles.ts14C000W600),
                  ],
                ),
              ],
            );
          },
        ),
        backgroundColor: Colors.white,
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
                icon: const Icon(Icons.settings, color: Colors.black),
              );
            },
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Doctor Dashboard', style: AppStyles.ts24C000W600),
            SizedBox(height: 10.h),
            Row(
              children: [
                DoctorDashBoardItem(header: 'Total', count: 15),
                SizedBox(width: 10.w),
                DoctorDashBoardItem(header: 'Pending', count: 12),
                SizedBox(width: 10.w),
                DoctorDashBoardItem(header: 'Completed', count: 3),
              ],
            ),
            SizedBox(height: 20.h),
            Column(
              children: [
                PrimaryButton(onPressed: () {}, label: 'Manage Appointments'),
                SizedBox(height: 10.h),
                PrimaryButton(onPressed: () {}, label: 'Set Available Slots'),
              ],
            ),
            SizedBox(height: 20.h),

            /// PLACEHOLDER FOR FUTURE FEATURES
            Text('Appointments & Slots', style: AppStyles.ts24C000W600),

            SizedBox(height: 10.h),

            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder:
                    (context, index) => RoundedContainerWithShadow(
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
                                  Text(
                                    "Jake Williams",
                                    style: AppStyles.ts14C000W600,
                                  ),

                                  Text(
                                    "10:00 am - 10:30 am",
                                    style: AppStyles.ts12C000W400,
                                  ),

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
                                child: PrimaryButton(
                                  onPressed: () {},
                                  label: "Start",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.w,
          child: Text('$label:', style: AppStyles.ts14C000W600),
        ),
        Expanded(child: Text(value, style: AppStyles.ts14C000W400)),
      ],
    );
  }
}

class DoctorDashBoardItem extends StatelessWidget {
  const DoctorDashBoardItem({
    super.key,
    required this.header,
    required this.count,
  });

  final String header;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RoundedContainerWithShadow(
        child: Column(
          children: [
            Text(header, style: AppStyles.ts14C000W600),
            SizedBox(height: 10.h),
            Text(count.toString(), style: AppStyles.ts24C000W600),
          ],
        ),
      ),
    );
  }
}

class RoundedContainerWithShadow extends StatelessWidget {
  const RoundedContainerWithShadow({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
