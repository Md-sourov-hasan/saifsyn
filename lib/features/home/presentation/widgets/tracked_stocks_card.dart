import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../../../main/controllers/main_navigation_controller.dart';
import 'stock_item.dart';

class TrackedStocksCard extends StatelessWidget {
  const TrackedStocksCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 0),
            spreadRadius: -3,
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
                localizationService.translate('trackedStocks'),
                style: TextStyle(
                  color: const Color(0xFF101727),
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final controller = Get.find<MainNavigationController>();
                  controller.changeTab(1);
                },
                child: Row(
                  children: [
                    Text(
                      localizationService.translate('viewAll'),
                      style: TextStyle(
                        color: const Color(0xFF00008B),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: const Color(0xFF00008B),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Stock List
          StockItem(
            symbol: 'AAPL',
            name: 'Apple Inc.',
            price: '\$178.25',
            change: '+2.4%',
            isPositive: true,
            isPrimary: true,
            halalStatus: localizationService.translate('halal'),
            riskLevel: localizationService.translate('lowRisk'),
          ),
          SizedBox(height: 12.h),
          StockItem(
            symbol: 'MSFT',
            name: 'Microsoft Corp.',
            price: '\$384.5',
            change: '+1.8%',
            isPositive: true,
            halalStatus: localizationService.translate('halal'),
            riskLevel: localizationService.translate('lowRisk'),
          ),
          SizedBox(height: 12.h),
          StockItem(
            symbol: 'GOOGL',
            name: 'Alphabet Inc.',
            price: '\$142.3',
            change: '-0.5%',
            isPositive: false,
            halalStatus: localizationService.translate('doubtful'),
            riskLevel: localizationService.translate('highRisk'),
          ),
        ],
      ),
    );
  }
}
