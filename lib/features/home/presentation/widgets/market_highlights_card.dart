import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'highlight_item.dart';

class MarketHighlightsCard extends StatelessWidget {
  const MarketHighlightsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Highlights',
            style: TextStyle(
              color: const Color(0xFF101727),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          const HighlightItem(
            icon: Icons.trending_up,
            iconColor: Color(0xFF16A34A),
            backgroundColor: Color(0xFFDCFCE7),
            title: 'Tech Sector Rally',
            description: 'Major tech stocks gain momentum',
          ),
          SizedBox(height: 16.h),
          const HighlightItem(
            icon: Icons.account_balance,
            iconColor: Color(0xFF2563EB),
            backgroundColor: Color(0xFFDBEAFE),
            title: 'Fed Interest Rate Decision',
            description: 'Rate expected to remain steady',
          ),
          SizedBox(height: 16.h),
          const HighlightItem(
            icon: Icons.local_gas_station,
            iconColor: Color(0xFFDC2626),
            backgroundColor: Color(0xFFFFE2E2),
            title: 'Oil Prices Decline',
            description: 'Crude oil drops 2% on supply concerns',
          ),
        ],
      ),
    );
  }
}
