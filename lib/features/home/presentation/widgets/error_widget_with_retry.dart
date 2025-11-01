import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:slot_booking_app/core/constants/app_constants.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/auth/presentation/widgets/primary_button.dart';

class ErrorWidgetWithRetry extends StatelessWidget {
  const ErrorWidgetWithRetry({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppConstants.failedLottie, repeat: false),
          SizedBox(height: 16.h),
          Text('Something went wrong', style: AppStyles.ts16CFFFFFFW500),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              errorMessage,
              style: AppStyles.ts12CFFFFFFW400,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          PrimaryButton(onPressed: onRetry, label: 'Retry'),
        ],
      ),
    );
  }
}
