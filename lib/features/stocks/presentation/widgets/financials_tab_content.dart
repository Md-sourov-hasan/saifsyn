import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/stocks/presentation/widgets/financials_category_tabs.dart';
// import 'interest_bearing_chart.dart';
// import 'compliance_action_buttons.dart';

class FinancialsTabContent extends StatefulWidget {
  const FinancialsTabContent({super.key});

  @override
  State<FinancialsTabContent> createState() => _FinancialsTabContentState();
}

class _FinancialsTabContentState extends State<FinancialsTabContent> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    // final localizationService = Get.find<LocalizationService>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Tabs (Business Activity, Interest-bearing, etc.)
        FinancialCategoryTabs(
          selectedCategory: selectedCategory,
          onCategorySelected: (index) {
            setState(() {
              selectedCategory = index;
            });
          },
        ),

        SizedBox(height: 14.h),
        _buildCategoryContent(),
      ],
    );
  }

  Widget _buildCategoryContent() {
    switch (selectedCategory) {
      case 0: // Per Share Data
        return _buildPerShareDataContent();
      case 1: // Ratios
        return _buildRatiosContent();
      case 2: // Statements
        return _buildStatementsContent();
      default:
        return _buildPerShareDataContent();
    }
  }

  Widget _buildPerShareDataContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ImagePath.perShareDataChart,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 24.h),
        Image.asset(
          ImagePath.perShareData,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildRatiosContent() {
    final localizationService = Get.find<LocalizationService>();
    final List<Map<String, String>> metrics = [
      {
        'label': localizationService.translate('revenuePerShare'),
        'value': 'Actual'
      },
      {'label': localizationService.translate('ebitPerShare'), 'value': '1.64'},
      {
        'label': localizationService.translate('earningsPerShare'),
        'value': '-0.58%'
      },
      {
        'label': localizationService.translate('dividendPerShare'),
        'value': '1.64'
      },
      {'label': localizationService.translate('epsForward'), 'value': '1.64'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image from Figma
        Image.asset(
          ImagePath.ratiosData,
          fit: BoxFit.cover,
        ),

        const SizedBox(height: 16),

        // Table Content
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizationService.translate('currencyUsd'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    localizationService.translate('year2025'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Metrics
              ...metrics.map((metric) => _buildMetricRow(
                    metric['label']!,
                    metric['value']!,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatementsContent() {
    final List<Map<String, String>> metrics = [
      {'label': 'Currency(USD)', 'value': '2025'},
      {'label': 'EBIT per Share (TTM)', 'value': '1.64'},
      {'label': 'Earnings per Share (EPS) (TTM)', 'value': '-0.58%'},
      {'label': 'Dividend per Share (TTM)', 'value': '1.64'},
      {'label': 'EPS Forward', 'value': '1.64'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Income Statements',
          style: TextStyle(
            color: const Color(0xFF101727),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 22.h),
        Image.asset(
          ImagePath.incomeStatementData,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 12.h),
        ...metrics.map((metric) => _buildMetricRow(
              metric['label']!,
              metric['value']!,
            )),
        SizedBox(height: 12.h),
        Image.asset(
          ImagePath.balanceSheetData,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 12.h),
        ...metrics.map((metric) => _buildMetricRow(
              metric['label']!,
              metric['value']!,
            )),
        SizedBox(height: 12.h),
        Image.asset(
          ImagePath.statement3,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
