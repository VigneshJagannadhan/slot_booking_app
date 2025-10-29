import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';

class CustomSwitchButton extends StatelessWidget {
  const CustomSwitchButton({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

  final ValueNotifier<bool> value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 1.sw,
          height: 45.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 15.w),
              Text(label, style: AppStyles.ts12CFFFFFFW500),
              Spacer(),
              Switch.adaptive(
                value: value.value,
                onChanged: (v) => value.value = v,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
