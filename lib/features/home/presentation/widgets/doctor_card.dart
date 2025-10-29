import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slot_booking_app/core/themes/app_colors.dart';
import 'package:slot_booking_app/core/themes/app_styles.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_entity.dart';
import 'package:slot_booking_app/features/home/presentation/widgets/availability_bubble.dart';
import 'package:slot_booking_app/utils/app_enums.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor});

  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 30.r,
            child: Text(
              doctor.name?.isNotEmpty == true
                  ? doctor.name![0].toUpperCase()
                  : '?',
              style: AppStyles.ts24CFFFFFFW800,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        doctor.name ?? 'Unknown',
                        style: AppStyles.ts14C000W600,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '${doctor.rating.toString()} ⭐',
                      style: AppStyles.ts14C000W600,
                    ),
                  ],
                ),
                Text(
                  doctor.designation ?? 'Designation',
                  style: AppStyles.ts12C000W600,
                ),
                Text(
                  doctor.hospitalOrClinic ?? 'Hospital or clinic name',
                  style: AppStyles.ts12C000W400,
                ),
                SizedBox(height: 5.h),
                AvailabiltyBubble(availability: Availability.available),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
