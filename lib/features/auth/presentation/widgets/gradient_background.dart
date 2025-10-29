import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/themes/app_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.child,
    this.gradients,
    this.padding,
  });

  final Widget child;
  final List<Color>? gradients;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors:
              gradients ?? [AppColors.primaryColor, AppColors.secondaryColor],
        ),
      ),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      child: child,
    );
  }
}
