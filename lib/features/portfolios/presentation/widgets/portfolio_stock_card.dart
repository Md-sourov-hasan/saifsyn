import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class PortfolioStockCard extends StatelessWidget {
  final String symbol;
  final String name;
  final String price;
  final String change;
  final String changePercent;
  final String supportPrice;
  final String resistancePrice;
  final String recommendation; // recommendation key: 'buy', 'hold', 'sell'
  final bool isPositive;
  final bool isPrimary;

  const PortfolioStockCard({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.supportPrice,
    required this.resistancePrice,
    required this.recommendation,
    this.isPositive = true,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/portfolio-stock-details',
          arguments: {
            'symbol': symbol,
            'name': name,
            'price': price,
            'supportPrice': supportPrice,
            'resistancePrice': resistancePrice,
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF00008B) : Colors.white,
          border: Border.all(
            width: 1,
            color: const Color(0xFFF0F4F9),
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 2,
              offset: Offset(0, 1),
              spreadRadius: -1,
            ),
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side: Icon + Stock info
            Expanded(
              child: Row(
                children: [
                  // Stock icon
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFF0F4F9),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        symbol.substring(0, 1),
                        style: TextStyle(
                          color: const Color(0xFF00008B),
                          fontSize: 18.sp,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Stock details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Symbol + Recommendation badge
                        Row(
                          children: [
                            Text(
                              symbol,
                              style: TextStyle(
                                color: isPrimary
                                    ? Colors.white
                                    : const Color(0xFF0E162B),
                                fontSize: 16.sp,
                                fontFamily: 'Arimo',
                                fontWeight: FontWeight.w700,
                                height: 1.50,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            _buildRecommendationBadge(),
                          ],
                        ),

                        // Company name
                        Text(
                          name,
                          style: TextStyle(
                            color: const Color(0xFF61738D),
                            fontSize: 12.sp,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 2.h),

                        // Support/Resistance
                        Text(
                          '${localizationService.translate('support')}: $supportPrice / ${localizationService.translate('resistance')}: $resistancePrice',
                          style: TextStyle(
                            color: const Color(0xFF90A1B8),
                            fontSize: 10.sp,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right side: Price info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Price
                Text(
                  price,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: isPrimary ? Colors.white : const Color(0xFF0E162B),
                    fontSize: 16.sp,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),

                // Change
                Text(
                  '$change ($changePercent)',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: isPositive
                        ? const Color(0xFF009966)
                        : const Color(0xFFE7000B),
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationBadge() {
    // recommendation passed as a key (e.g. 'buy', 'hold', 'sell')
    final key = recommendation.toLowerCase();

    Color bgColor;
    Color borderColor;

    switch (key) {
      case 'buy':
        bgColor = const Color(0xFFD0FAE5);
        borderColor = const Color(0xFFA4F3CF);
        break;
      case 'hold':
        bgColor = const Color(0xFFFEF3C6);
        borderColor = const Color(0xFFFDE585);
        break;
      case 'sell':
        bgColor = const Color(0xFFFFE5E5);
        borderColor = const Color(0xFFFFCCCC);
        break;
      default:
        bgColor = const Color(0xFFD0FAE5);
        borderColor = const Color(0xFFA4F3CF);
    }

    final label = Get.isRegistered<LocalizationService>()
        ? Get.find<LocalizationService>().translate(key)
        : recommendation;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF0A0A0A),
          fontSize: 10.sp,
          fontFamily: 'Arimo',
          fontWeight: FontWeight.w700,
          height: 1.33,
        ),
      ),
    );
  }
}
