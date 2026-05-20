import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'compliance_category_tabs.dart';
import 'halal_compliance_chart.dart';
import 'interest_bearing_chart.dart';
import 'compliance_action_buttons.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class HalalTabContent extends StatefulWidget {
  const HalalTabContent({super.key});

  @override
  State<HalalTabContent> createState() => _HalalTabContentState();
}

class _HalalTabContentState extends State<HalalTabContent> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Tabs (Business Activity, Interest-bearing, etc.)
        ComplianceCategoryTabs(
          selectedCategory: selectedCategory,
          onCategorySelected: (index) {
            setState(() {
              selectedCategory = index;
            });
          },
        ),

        SizedBox(height: 14.h),

        // Dynamic content based on selected category
        _buildCategoryContent(),
      ],
    );
  }

  Widget _buildCategoryContent() {
    switch (selectedCategory) {
      case 0: // Business Activity
        return _buildBusinessActivityContent();
      case 1: // Interest-bearing
        return _buildInterestBearingContent();
      case 2: // Interest-bearing debt
        return _buildInterestBearingDebtContent();
      default:
        return _buildBusinessActivityContent();
    }
  }

  Widget _buildBusinessActivityContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Get.find<LocalizationService>().translate('businessActivity'),
          style: TextStyle(
            color: const Color(0xFF101727),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 22.h),
        const HalalComplianceChart(
          halalPercentage: 95.96,
          doubtfulPercentage: 0.0,
          notHalalPercentage: 4.04,
        ),
        SizedBox(height: 24.h),
        ComplianceActionButtons(
          onCalculationTap: () {
            // TODO: Navigate to calculation screen
          },
          onDetailedReportTap: () {
            // TODO: Navigate to detailed report screen
          },
        ),
      ],
    );
  }

  Widget _buildInterestBearingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Get.find<LocalizationService>().translate('interestBearing'),
          style: TextStyle(
            color: const Color(0xFF101727),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 22.h),
        const InterestBearingChart(
          compliancePercentage: 95.96,
          nonCompliancePercentage: 4.04,
        ),
        SizedBox(height: 56.h),
        ComplianceActionButtons(
          onCalculationTap: () {
            // TODO: Navigate to calculation screen
          },
          onDetailedReportTap: () {
            // TODO: Navigate to detailed report screen
          },
        ),
      ],
    );
  }

  Widget _buildInterestBearingDebtContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Get.find<LocalizationService>().translate('interestBearingDebt'),
          style: TextStyle(
            color: const Color(0xFF101727),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 22.h),
        const InterestBearingChart(
          compliancePercentage: 95.96,
          nonCompliancePercentage: 4.04,
        ),
        SizedBox(height: 56.h),
        ComplianceActionButtons(
          onCalculationTap: () {
            // TODO: Navigate to calculation screen
          },
          onDetailedReportTap: () {
            // TODO: Navigate to detailed report screen
          },
        ),
      ],
    );
  }
}
