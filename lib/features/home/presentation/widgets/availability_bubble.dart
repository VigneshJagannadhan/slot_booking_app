import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/utils/app_enums.dart';

class AvailabiltyBubble extends StatelessWidget {
  const AvailabiltyBubble({super.key, required this.availability});

  final Availability availability;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: _getBubbleColor(availability),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      child: Text(
        _getBubbleText(availability),
        style: AppStyles.ts12C000W700.copyWith(
          fontSize: 10.sp,
          color: _getBubbleTextColor(availability),
        ),
      ),
    );
  }

  String _getBubbleText(Availability availability) {
    switch (availability) {
      case Availability.available:
        return "Slots Available";
      case Availability.limited:
        return "Limited Slots";
      case Availability.filled:
        return "Slots Filled";
    }
  }

  Color _getBubbleColor(Availability availability) {
    switch (availability) {
      case Availability.available:
        return Colors.greenAccent.shade100;
      case Availability.limited:
        return Colors.orangeAccent.shade100;
      case Availability.filled:
        return Colors.redAccent.shade100;
    }
  }

  Color _getBubbleTextColor(Availability availability) {
    switch (availability) {
      case Availability.available:
        return Colors.green.shade900;
      case Availability.limited:
        return Colors.orange.shade900;
      case Availability.filled:
        return Colors.red.shade900;
    }
  }
}
