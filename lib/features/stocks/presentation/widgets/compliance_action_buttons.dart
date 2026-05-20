import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class ComplianceActionButtons extends StatelessWidget {
  final VoidCallback? onCalculationTap;
  final VoidCallback? onDetailedReportTap;

  const ComplianceActionButtons({
    super.key,
    this.onCalculationTap,
    this.onDetailedReportTap,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Column(
      children: [
        _buildActionButton(
          'calculation',
          localizationService.translate('calculation'),
          onCalculationTap,
        ),
        SizedBox(height: 28.h),
        _buildActionButton(
          'detailedReport',
          localizationService.translate('detailedReport'),
          onDetailedReportTap,
        ),
      ],
    );
  }

  Widget _buildActionButton(String key, String title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF99A1AF),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: key == 'calculation'
                  ? const Color(0xFF444242)
                  : const Color(0xFF101727),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
