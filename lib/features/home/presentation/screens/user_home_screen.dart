import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/network_helper.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
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
      body: GradientBackground(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                  ],
                ),
              ),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchBarDelegate(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Text(
                  'Available Doctors',
                  style: AppStyles.ts24CFFFFFFW600,
                ),
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
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
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
                      (context, index) =>
                          DoctorCard(doctor: state.doctors[index]),
                      childCount: state.doctors.length,
                    ),
                  );
                }

                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 150;
  @override
  double get maxExtent => 150;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
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

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) => false;
}
