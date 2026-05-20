import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class FinancialCategoryTabs extends StatelessWidget {
  final int selectedCategory;
  final Function(int) onCategorySelected;

  const FinancialCategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryTab(localizationService.translate('perShareData'), 0),
          SizedBox(width: 7.w),
          _buildCategoryTab(localizationService.translate('ratios'), 1),
          SizedBox(width: 7.w),
          _buildCategoryTab(localizationService.translate('statements'), 2),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String title, int index) {
    final isSelected = selectedCategory == index;
    return GestureDetector(
      onTap: () => onCategorySelected(index),
      child: Container(
        height: 38.h,
        constraints: BoxConstraints(minWidth: 109.w),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00008B) : Colors.white,
          border: Border.all(
            color:
                isSelected ? const Color(0xFF00008B) : const Color(0x540101C1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFFA59F9F),
              fontSize: 12.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
