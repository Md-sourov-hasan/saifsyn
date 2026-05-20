import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class RiskFilterChips extends StatelessWidget {
  const RiskFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = 'All Risk'.obs;
    final localizationService = Get.find<LocalizationService>();

    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip(
              localizationService.translate('allRisk'), selectedFilter),
          SizedBox(width: 8.w),
          _buildFilterChip(
              localizationService.translate('lowRisk'), selectedFilter),
          SizedBox(width: 8.w),
          _buildFilterChip(
              localizationService.translate('mediumRisk'), selectedFilter),
          SizedBox(width: 8.w),
          _buildFilterChip(
              localizationService.translate('highRisk'), selectedFilter),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, RxString selectedFilter) {
    return Obx(() {
      final isSelected = selectedFilter.value == label;
      return GestureDetector(
        onTap: () => selectedFilter.value = label,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFF00008B) : const Color(0xFFF3F4F6),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF00008B)
                  : const Color(0x5600A63E),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF354152),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    });
  }
}
