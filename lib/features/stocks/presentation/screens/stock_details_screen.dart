import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/stock_details_header.dart';
import '../widgets/stock_details_tab_bar.dart';
import '../widgets/halal_tab_content.dart';
import '../widgets/forecast_tab_content.dart';
import '../widgets/analysis_tab_content.dart';
import '../widgets/financials_tab_content.dart';

class StockDetailsScreen extends StatefulWidget {
  const StockDetailsScreen({super.key});

  @override
  State<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    // Get stock data from arguments
    final Map<String, dynamic> stockData = Get.arguments ??
        {
          'symbol': 'AAPL',
          'name': 'Apple Inc.',
          'price': '\$178.25',
          'change': '+2.4%',
          'isPositive': true,
          'isHalalCertified': true,
          'riskLevel': 'LOW RISK',
        };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // top: false,
        bottom: false,
        child: Column(
          children: [
            // Fixed Header
            StockDetailsHeader(stockData: stockData),

            // Tab Bar (Fixed)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  StockDetailsTabBar(
                    selectedIndex: selectedTab,
                    onTabSelected: (index) {
                      setState(() {
                        selectedTab = index;
                      });
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),

            // Scrollable Tab Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Column(
                  children: [
                    _buildTabContent(),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return const HalalTabContent();
      case 1:
        return const ForecastTabContent();
      case 2:
        return const AnalysisTabContent();
      case 3:
        return const FinancialsTabContent();
      default:
        return const HalalTabContent();
    }
  }
}
