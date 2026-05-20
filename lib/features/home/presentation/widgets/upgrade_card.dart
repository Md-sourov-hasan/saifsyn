import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';
import 'package:saifsyn/features/subscription/controllers/subscription_controller.dart';
import 'package:saifsyn/features/subscription/presentation/screens/subscription_screen.dart';

class UpgradeCard extends StatelessWidget {
  const UpgradeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionController controller =
        Get.find<SubscriptionController>();
    final localizationService = Get.find<LocalizationService>();

    return Obx(
      () {
        // If user is elite, show already subscribed info
        if (controller.isEliteMember) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              border: Border.all(
                color: const Color(0xFF2FAF84),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImagePath.premiumIcon,
                            width: 24.w,
                            height: 24.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            localizationService.translate('eliteMember'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        localizationService.translate('allFeaturesUnlocked'),
                        style: TextStyle(
                          color: const Color(0xFFD0FAE4),
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    localizationService.translate('subscribed'),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Otherwise, show upgrade button
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            border: Border.all(
              color: const Color(0xFF2FAF84),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizationService.translate('upgradeToElite'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      localizationService.translate('unlockAllFeatures'),
                      style: TextStyle(
                        color: const Color(0xFFD0FAE4),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SubscriptionScreen());
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDC700),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    localizationService.translate('upgrade'),
                    style: TextStyle(
                      color: const Color(0xFF723D0A),
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
