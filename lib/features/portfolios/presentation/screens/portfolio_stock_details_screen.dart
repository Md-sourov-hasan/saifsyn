import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/portfolio_details_header.dart';
import '../widgets/price_action_chart.dart';
import '../widgets/key_levels_card.dart';
import '../widgets/buy_sell_zones.dart';
import '../widgets/comments_section.dart';

class PortfolioStockDetailsScreen extends StatelessWidget {
  const PortfolioStockDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get stock data from arguments
    final Map<String, dynamic> stockData = Get.arguments ??
        {
          'symbol': 'AAPL',
          'name': 'Apple Inc.',
          'price': '\$173.50',
          'supportPrice': '170',
          'resistancePrice': '175',
        };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            PortfolioDetailsHeader(
              symbol: stockData['symbol'] ?? 'AAPL',
              name: stockData['name'] ?? 'Apple Inc.',
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 13.w)
                    .copyWith(top: 23.h, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Action Chart
                    PriceActionChart(
                      price: stockData['price'] ?? '\$173.50',
                      chartData: [
                        const FlSpot(0, 1.5), // Start low
                        const FlSpot(2, 3.5), // Steady climb
                        const FlSpot(4, 5.0), // Peak 1
                        const FlSpot(6, 4.5), // The slight dip
                        const FlSpot(8, 8.5),
                      ],
                    ),

                    SizedBox(height: 17.h),

                    // Key Levels
                    KeyLevelsCard(
                      resistancePrice: stockData['resistancePrice'] ?? '175',
                      supportPrice: stockData['supportPrice'] ?? '170',
                    ),

                    SizedBox(height: 25.h),

                    // Buy/Sell Zones
                    const BuySellZones(),

                    SizedBox(height: 42.h),

                    // Comments Section
                    const CommentsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
