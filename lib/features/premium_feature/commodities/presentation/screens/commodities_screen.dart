import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/premium_feature_header.dart';
import '../widgets/commodity_info_card.dart';
import '../widgets/commodity_price_card.dart';
import '../widgets/market_analysis_card.dart';

class CommoditiesScreen extends StatelessWidget {
  const CommoditiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              const PremiumFeatureHeader(
                title: 'Commodities',
                subtitle: 'Track prices and trends across major commodities.',
              ),

              SizedBox(height: 25.h),

              // Info Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: const CommodityInfoCard(),
              ),

              SizedBox(height: 25.h),

              // Commodity Price Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    CommodityPriceCard(
                      name: 'Gold',
                      symbol: 'XAU',
                      currentPrice: '\$2043.5',
                      changePercent: '+0.8%',
                      isPositive: true,
                      unit: '/oz',
                    ),
                    SizedBox(height: 16.h),
                    CommodityPriceCard(
                      name: 'Silver',
                      symbol: 'XAG',
                      currentPrice: '\$24.35',
                      changePercent: '+1.2%',
                      isPositive: true,
                      unit: '/oz',
                    ),
                    SizedBox(height: 16.h),
                    CommodityPriceCard(
                      name: 'Oil (WTI)',
                      symbol: 'CL',
                      currentPrice: '\$72.8',
                      changePercent: '-1.5%',
                      isPositive: false,
                      unit: '/barrel',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 21.h),

              // Market Analysis Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: const MarketAnalysisCard(),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
