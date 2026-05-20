import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class BuySellZones extends StatelessWidget {
  const BuySellZones({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizationService.translate('buySellZones'),
              style: TextStyle(
                color: const Color(0xFF0E162B),
                fontSize: 16.sp,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w700,
                height: 1.50,
              ),
            ),
            Text(
              localizationService.translate('updatesEvery5m'),
              style: TextStyle(
                color: const Color(0xFF90A1B8),
                fontSize: 12.sp,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Container(
            width: double.infinity,
            height: 8.h,
            color: const Color(0xFFF1F5F9),
            child: Row(
              children: [
                // Sell zone (red)
                Container(
                  width: 105.w,
                  height: 8.h,
                  color: const Color(0xFFFF6467),
                ),
                // Hold zone (yellow)
                Container(
                  width: 70.w,
                  height: 8.h,
                  color: const Color(0xFFFFD230),
                ),
                // Buy zone (green) - takes remaining space
                Expanded(
                  child: Container(
                    height: 8.h,
                    color: const Color(0xFF00D492),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 8.h),

        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizationService.translate('sellZone'),
              style: TextStyle(
                color: const Color(0xFF61738D),
                fontSize: 10.sp,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            Text(
              localizationService.translate('hold'),
              style: TextStyle(
                color: const Color(0xFF61738D),
                fontSize: 10.sp,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            Text(
              localizationService.translate('buyZone'),
              style: TextStyle(
                color: const Color(0xFF61738D),
                fontSize: 10.sp,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
