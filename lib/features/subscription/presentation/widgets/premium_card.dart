import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';
import 'package:saifsyn/features/subscription/controllers/subscription_controller.dart';

class PremiumCard extends StatelessWidget {
  const PremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();
    final localizationService = Get.find<LocalizationService>();

    return Obx(
      () => Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF00008B),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Crown icon
            Container(
              width: 48.w,
              height: 48.w,
              decoration: const BoxDecoration(
                color: Color(0xFFFDC700),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                ImagePath.premiumIcon,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(width: 12.w),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.isEliteMember
                        ? localizationService.translate('eliteMember')
                        : localizationService.translate('goElite'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                  ),
                  Text(
                    controller.isEliteMember
                        ? localizationService.translate('allFeaturesUnlocked')
                        : localizationService.translate('unlockAllFeatures'),
                    style: TextStyle(
                      color: const Color(0xFFD0FAE4),
                      fontSize: 14.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
