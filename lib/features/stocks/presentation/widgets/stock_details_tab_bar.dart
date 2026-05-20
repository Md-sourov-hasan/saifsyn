import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class StockDetailsTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const StockDetailsTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Row(
      children: [
        _buildTab(localizationService.translate('halalTab'), 0),
        SizedBox(width: 25.w),
        _buildTab(localizationService.translate('forecastTab'), 1),
        SizedBox(width: 25.w),
        _buildTab(localizationService.translate('analysisTab'), 2),
        SizedBox(width: 25.w),
        _buildTab(localizationService.translate('financialsTab'), 3),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF00008B)
                  : const Color(0xFF909090),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4.h),
          if (isSelected)
            Container(
              height: 2.h,
              width: title.length * 8.w,
              decoration: BoxDecoration(
                color: const Color(0xFF00008B),
                borderRadius: BorderRadius.circular(2.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00008B).withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            )
          else
            SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
