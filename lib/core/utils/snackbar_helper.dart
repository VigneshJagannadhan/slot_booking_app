import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/utils/app_styles.dart';

class SnackbarHelper {
  static void showSnackbar({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        content: Text(
          message,
          style: AppStyles.ts14CFFFFFFW400,
          textAlign: TextAlign.justify,
        ),
        backgroundColor:
            isError
                ? const Color.fromARGB(161, 245, 61, 47)
                : const Color.fromARGB(132, 76, 233, 81),
      ),
    );
  }
}
