import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class MarketHighlightsSection extends StatelessWidget {
  const MarketHighlightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizationService.translate('marketHighlights'),
          style: TextStyle(
            color: const Color(0xFF101727),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            // Top Gainer Card
            Expanded(
              child: _buildHighlightCard(
                title: localizationService.translate('topGainer'),
                ticker: 'TSLA',
                change: '+4.8%',
                isPositive: true,
                iconColor: const Color(0xFFD0FAE5),
                icon: Icons.trending_up,
              ),
            ),
            SizedBox(width: 16.w),
            // Top Loser Card
            Expanded(
              child: _buildHighlightCard(
                title: localizationService.translate('topLoser'),
                ticker: 'MSFT',
                change: '- 1.2%',
                isPositive: false,
                iconColor: const Color(0x1EE7000B),
                icon: Icons.trending_down,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighlightCard({
    required String title,
    required String ticker,
    required String change,
    required bool isPositive,
    required Color iconColor,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 5,
            offset: const Offset(0, 0),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              icon,
              color: isPositive
                  ? const Color(0xFF00008B)
                  : const Color(0xFFE7000B),
              size: 24.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF101727),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            ticker,
            style: TextStyle(
              color: const Color(0xFF697282),
              fontSize: 14.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            change,
            style: TextStyle(
              color: isPositive
                  ? const Color(0xFF00008B)
                  : const Color(0xFFE7000B),
              fontSize: 14.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
