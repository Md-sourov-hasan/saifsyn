import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:get/get.dart';

class SubscriptionInfoCard extends StatelessWidget {
  final String text;

  const SubscriptionInfoCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: Border.all(
          width: 1.11,
          color: const Color(0xFFBDDAFF),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${localizationService.translate('important')} ',
              style: TextStyle(
                color: const Color(0xFF1B388E),
                fontSize: 14.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                height: 1.43,
              ),
            ),
            TextSpan(
              text: text,
              style: TextStyle(
                color: const Color(0xFF1B388E),
                fontSize: 14.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
