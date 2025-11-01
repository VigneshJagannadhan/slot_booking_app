import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/helpers/network_helper.dart';
import 'package:slot_booking_app/features/appointments/presentation/blocs/appointment_bloc.dart';
import 'package:slot_booking_app/features/appointments/presentation/blocs/appointment_events.dart';
import 'package:slot_booking_app/features/appointments/presentation/blocs/appointment_state.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/gradient_background.dart';
import 'package:slot_booking_app/features/home/presentation/screens/doctor_home_screen.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/error_widget_with_retry.dart';
import 'package:slot_booking_app/utils/snackbar_helper.dart';

class AppointmentsScreen extends StatefulWidget {
  static const String route = 'appointments';
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentBloc>().add(LoadAppointment());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(),
          SliverToBoxAdapter(
            child: GradientBackground(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              addSpaceAtTop: true,
              child: Column(
                children: [
                  BlocConsumer<AppointmentBloc, AppointmentState>(
                    listener: (context, state) {
                      /// SHOW SNACKBAR ON ERROR
                      if (state is AppointmentFailure) {
                        SnackbarHelper.showSnackbar(
                          context: context,
                          message: NetworkHelper.handleNetworkErrMsg(
                            state.message,
                          ),
                          isError: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      /// SHOW LOADING INDICATOR
                      if (state is AppointmentLoading) {
                        return Center(child: CupertinoActivityIndicator());
                      }

                      /// SHOW ERROR WIDGET WITH RETRY BUTTON
                      if (state is AppointmentFailure) {
                        return ErrorWidgetWithRetry(
                          errorMessage: state.message,
                          onRetry: () {
                            context.read<AppointmentBloc>().add(
                              LoadAppointment(),
                            );
                          },
                        );
                      }

                      /// SHOW EMPTY LIST HANDLER
                      if (state is AppointmentsLoaded) {
                        // if (state.appointments.isEmpty) {
                        //   return EmptyListHandler(
                        //     isEmpty: true,
                        //     emptyListMessage:
                        //         'You do not have any appointments scheduled for today',
                        //     child: const SizedBox.shrink(),
                        //   );
                        // }

                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 30.h, top: 30.h),
                            itemCount: 10,
                            itemBuilder: (context, index) => AppointmentItem(),
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
