import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/network_helper.dart';
import 'package:slot_booking_app/core/themes/app_colors.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/gradient_background.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 120.h,
        backgroundColor: Colors.transparent,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(radius: 25.r),
                SizedBox(width: 10.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Welcome,', style: AppStyles.ts14CFFFFFFW400),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        UserEntity? user;
                        if (state is UserSuccess) {
                          user = state.user;
                        }
                        return Text(
                          user?.name ?? "Guest",
                          style: AppStyles.ts18CFFFFFFW700,
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  onPressed:
                      () => context.read<AuthBloc>().add(LogoutRequested()),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            CustomSearchBar(),
          ],
        ),
      ),
      body: GradientBackground(
        child: Column(
          children: [
            SizedBox(height: 170.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Doctors',
                style: AppStyles.ts24CFFFFFFW600,
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
                  return Center(child: CupertinoActivityIndicator());
                }

                /// SHOW ERROR WIDGET WITH RETRY BUTTON
                if (state is DoctorFailure) {
                  return ErrorWidgetWithRetry(
                    errorMessage: state.message,
                    onRetry: () {
                      context.read<DoctorBloc>().add(LoadDoctors());
                    },
                  );
                }

                /// SHOW EMPTY LIST HANDLER
                if (state is DoctorLoaded) {
                  if (state.doctors.isEmpty) {
                    return EmptyListHandler(
                      isEmpty: true,
                      emptyListMessage: 'No doctors available',
                      child: const SizedBox.shrink(),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 50.h),
                      itemCount: state.doctors.length,
                      itemBuilder:
                          (context, index) =>
                              DoctorCard(doctor: state.doctors[index]),
                    ),
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.h),
      alignment: Alignment.bottomCenter,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
