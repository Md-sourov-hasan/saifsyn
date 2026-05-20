import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/subscription/controllers/subscription_controller.dart';

class SubscribeButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SubscribeButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final SubscriptionController controller =
        Get.find<SubscriptionController>();
    final localizationService = Get.find<LocalizationService>();

    return Column(
      children: [
        Obx(
          () => GestureDetector(
            onTap: (controller.isSelectedPlanSubscribed ||
                    controller.isProcessingPayment)
                ? null
                : onPressed,
            child: Container(
              width: double.infinity,
              height: 56.h,
              decoration: BoxDecoration(
                color: (controller.isSelectedPlanSubscribed ||
                        controller.isProcessingPayment)
                    ? Colors.grey
                    : const Color(0xFF00008B),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: controller.isProcessingPayment
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        controller.isSelectedPlanSubscribed
                            ? localizationService.translate('alreadySubscribed')
                            : localizationService.translate('subscribeNow'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
              ),
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Disclaimer text
        Text(
          localizationService.translate('cancelAnytimeNoQuestions'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF697282),
            fontSize: 14.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
      ],
    );
  }
}
