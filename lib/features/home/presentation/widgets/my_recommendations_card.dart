import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/main/controllers/main_navigation_controller.dart';

class MyRecommendationsCard extends StatelessWidget {
  const MyRecommendationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainNavigationController>();
    final localizationService = Get.find<LocalizationService>();

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          controller.changeTab(2);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF00008B),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              // Text section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizationService.translate('myRecommendations'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      localizationService.translate('viewCuratedPortfolios'),
                      style: TextStyle(
                        color: const Color(0xFFFEF3C6),
                        fontSize: 16.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withValues(alpha: 0.9),
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
