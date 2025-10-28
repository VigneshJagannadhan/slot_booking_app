import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        ? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 40.r, color: Colors.grey),
              SizedBox(height: 10.h),
              Text(
                emptyListMessage,
                style: AppStyles.ts14C000W400,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
        : child;
  }
}
