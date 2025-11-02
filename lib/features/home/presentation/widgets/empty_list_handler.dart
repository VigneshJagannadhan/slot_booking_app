import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:slot_booking_app/core/constants/app_constants.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';

class EmptyListHandler extends StatelessWidget {
  const EmptyListHandler({
    super.key,
    required this.child,
    required this.isEmpty,
    required this.emptyListMessage,
  });

  final Widget child;
  final bool isEmpty;
  final String emptyListMessage;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200.h,
                  child: Lottie.asset(AppConstants.emptyLottie),
                ),
                SizedBox(height: 10.h),
                Text(
                  emptyListMessage,
                  style: AppStyles.ts14CFFFFFFW400,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
        : child;
  }
}
