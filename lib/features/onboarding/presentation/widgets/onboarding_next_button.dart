import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLastPage;

  const OnboardingNextButton({
    super.key,
    required this.onTap,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 180.w,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          child: Text(
            isLastPage ? localizationService.translate('getStarted') : localizationService.translate('next'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF00008B),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
