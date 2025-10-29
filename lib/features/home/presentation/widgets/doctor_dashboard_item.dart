import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/rounded_shadow_container.dart';

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
    return RoundedContainerWithShadow(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(header, style: AppStyles.ts14C000W600),
          SizedBox(height: 10.h),
          Text(count.toString(), style: AppStyles.ts24C000W600),
        ],
      ),
    );
  }
}
