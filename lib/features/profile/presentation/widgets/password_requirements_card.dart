import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class PasswordRequirementsCard extends StatelessWidget {
  const PasswordRequirementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: Border.all(
          width: 1.11,
          color: const Color(0xFFBDDAFF),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizationService.translate('passwordRequirementsTitle'),
            style: TextStyle(
              color: const Color(0xFF1B388E),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.h),
          _buildRequirement(localizationService.translate('passwordMin8')),
          SizedBox(height: 4.h),
          _buildRequirement(localizationService
              .translate('passwordMustContainUppercaseLowercase')),
          SizedBox(height: 4.h),
          _buildRequirement(
              localizationService.translate('passwordMustContainNumber')),
          SizedBox(height: 4.h),
          _buildRequirement(
              localizationService.translate('passwordMustContainSpecialChar')),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 16.sp,
          color: const Color(0xFF1347E5),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xFF1347E5),
              fontSize: 14.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
