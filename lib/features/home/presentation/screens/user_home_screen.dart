import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/navigation_helper.dart';
import 'package:slot_booking_app/core/helpers/network_helper.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/screens/register_screen.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_bloc.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_events.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_state.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/doctor_card.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/empty_list_handler.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/error_widget_with_retry.dart';
import 'package:slot_booking_app/utils/snackbar_helper.dart';

class UserHomeScreen extends StatefulWidget {
  static const String route = 'user_home';
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorBloc>().add(LoadDoctors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  child: Text('VJ', style: AppStyles.ts14C000W400),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome,', style: AppStyles.ts12C000W400),
                    Text('Vignesh Jagannadhan', style: AppStyles.ts14C000W600),
                  ],
                ),
              ],
            ),
            backgroundColor: Colors.amber,
            expandedHeight: 200.h,
            flexibleSpace: Container(),

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
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Text('Available Doctors', style: AppStyles.ts24C000W600),
            ),
          ),
          BlocConsumer<DoctorBloc, DoctorState>(
            listener: (context, state) {
              /// SHOW SNACKBAR ON ERROR
              if (state is DoctorFailure) {
                SnackbarHelper.showSnackbar(
                  context: context,
                  message: NetworkHelper.handleNetworkErrMsg(state.message),
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              /// SHOW LOADING INDICATOR
              if (state is DoctorLoading) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                );
              }

              /// SHOW ERROR WIDGET WITH RETRY BUTTON
              if (state is DoctorFailure) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: ErrorWidgetWithRetry(
                      errorMessage: state.message,
                      onRetry: () {
                        context.read<DoctorBloc>().add(LoadDoctors());
                      },
                    ),
                  ),
                );
              }

              /// SHOW EMPTY LIST HANDLER
              if (state is DoctorLoaded) {
                if (state.doctors.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: EmptyListHandler(
                        isEmpty: true,
                        emptyListMessage: 'No doctors available',
                        child: const SizedBox.shrink(),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: DoctorCard(doctor: state.doctors[index]),
                    ),
                    childCount: state.doctors.length,
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}
