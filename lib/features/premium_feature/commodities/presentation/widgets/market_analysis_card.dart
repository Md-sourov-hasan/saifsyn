import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketAnalysisCard extends StatelessWidget {
  const MarketAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFD6D6D6),
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Market Analysis',
            style: TextStyle(
              color: const Color(0xFF101727),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          SizedBox(height: 12.h),

          // Description
          Text(
            'Precious metals show stable performance as safe-haven assets. Energy commodities experiencing volatility due to global supply dynamics.',
            style: TextStyle(
              color: const Color(0xFF495565),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          SizedBox(height: 12.h),

          // Outlooks
          Column(
            children: [
              _buildOutlookRow(
                'Gold Outlook:',
                'Bullish',
                const Color(0xFF00008B),
              ),
              SizedBox(height: 8.h),
              _buildOutlookRow(
                'Oil Outlook:',
                'Neutral',
                const Color(0xFFD08700),
              ),
              SizedBox(height: 8.h),
              _buildOutlookRow(
                'Silver Outlook:',
                'Bullish',
                const Color(0xFF00008B),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOutlookRow(String label, String outlook, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF495565),
            fontSize: 14.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
        Text(
          outlook,
          style: TextStyle(
            color: color,
            fontSize: 14.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
      ],
    );
  }
}
