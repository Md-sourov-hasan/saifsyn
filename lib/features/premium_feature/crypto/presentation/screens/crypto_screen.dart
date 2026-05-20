import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/premium_feature_header.dart';
import '../widgets/crypto_info_card.dart';
import '../widgets/crypto_warning_card.dart';
import '../widgets/crypto_card.dart';
import '../widgets/crypto_market_overview_card.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

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
                title: 'Cryptocurrency',
                subtitle:
                    'Track prices and trends of popular cryptocurrencies.',
              ),

              SizedBox(height: 25.h),

              // Info Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: const CryptoInfoCard(),
              ),

              SizedBox(height: 15.h),

              // Warning Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: const CryptoWarningCard(),
              ),

              SizedBox(height: 30.h),

              // Crypto Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: Column(
                  children: [
                    CryptoCard(
                      symbol: 'BTC',
                      name: 'Bitcoin',
                      price: '\$67,420',
                      marketCap: '\$1.32T',
                      changePercent: '+3.5%',
                      isPositive: true,
                    ),
                    SizedBox(height: 16.h),
                    CryptoCard(
                      symbol: 'ETH',
                      name: 'Ethereum',
                      price: '\$3,890',
                      marketCap: '\$467B',
                      changePercent: '+4.2%',
                      isPositive: true,
                    ),
                    SizedBox(height: 16.h),
                    CryptoCard(
                      symbol: 'BNB',
                      name: 'Binance Coin',
                      price: '\$312',
                      marketCap: '\$48B',
                      changePercent: '+2.1%',
                      isPositive: true,
                    ),
                    SizedBox(height: 16.h),
                    CryptoCard(
                      symbol: 'SOL',
                      name: 'Solana',
                      price: '\$98',
                      marketCap: '\$43B',
                      changePercent: '+6.8%',
                      isPositive: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 22.h),

              // Market Overview Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: const CryptoMarketOverviewCard(),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
