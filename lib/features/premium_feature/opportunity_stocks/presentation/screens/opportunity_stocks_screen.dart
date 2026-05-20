import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/common/widgets/premium_feature_header.dart';
import '../widgets/opportunity_info_card.dart';
import '../widgets/stock_opportunity_card.dart';
import '../widgets/disclaimer_card.dart';
import '../../../../stocks/presentation/screens/stock_details_screen.dart';

class OpportunityStocksScreen extends StatelessWidget {
  const OpportunityStocksScreen({super.key});

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
                title: 'Opportunity Stocks',
                subtitle:
                    'Discover high-potential stocks and market opportunities.',
              ),

              SizedBox(height: 16.h),

              // Info Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: const OpportunityInfoCard(),
              ),

              SizedBox(height: 27.h),

              // Stock Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: Column(
                  children: [
                    StockOpportunityCard(
                      ticker: 'CRWD',
                      companyName: 'CrowdStrike',
                      currentPrice: '\$289.4',
                      changePercent: '+5.2%',
                      upsidePotential: '+35%',
                      reason: 'Strong cybersecurity growth',
                      onViewDetails: () {
                        Get.to(
                          () => const StockDetailsScreen(),
                          arguments: {
                            'symbol': 'CRWD',
                            'name': 'CrowdStrike',
                            'price': '\$289.4',
                            'change': '+5.2%',
                            'isPositive': true,
                            'isHalalCertified': true,
                            'riskLevel': 'MEDIUM RISK',
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    StockOpportunityCard(
                      ticker: 'PLTR',
                      companyName: 'Palantir',
                      currentPrice: '\$38.9',
                      changePercent: '+3.8%',
                      upsidePotential: '+28%',
                      reason: 'AI platform expansion',
                      onViewDetails: () {
                        Get.to(
                          () => const StockDetailsScreen(),
                          arguments: {
                            'symbol': 'PLTR',
                            'name': 'Palantir',
                            'price': '\$38.9',
                            'change': '+3.8%',
                            'isPositive': true,
                            'isHalalCertified': true,
                            'riskLevel': 'HIGH RISK',
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    StockOpportunityCard(
                      ticker: 'SQ',
                      companyName: 'Block Inc.',
                      currentPrice: '\$89.6',
                      changePercent: '+2.1%',
                      upsidePotential: '+42%',
                      reason: 'Fintech innovation leader',
                      onViewDetails: () {
                        Get.to(
                          () => const StockDetailsScreen(),
                          arguments: {
                            'symbol': 'SQ',
                            'name': 'Block Inc.',
                            'price': '\$89.6',
                            'change': '+2.1%',
                            'isPositive': true,
                            'isHalalCertified': true,
                            'riskLevel': 'MEDIUM RISK',
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 36.h),

              // Disclaimer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: const DisclaimerCard(),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
