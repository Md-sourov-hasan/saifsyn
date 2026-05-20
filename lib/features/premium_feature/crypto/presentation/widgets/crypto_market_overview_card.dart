import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoMarketOverviewCard extends StatelessWidget {
  const CryptoMarketOverviewCard({super.key});

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
            'Market Overview',
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
            'Cryptocurrency markets showing strong momentum. Bitcoin leading the rally with renewed institutional interest. Altcoins following positive sentiment.',
            style: TextStyle(
              color: const Color(0xFF495565),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          SizedBox(height: 12.h),

          // Islamic Finance Note
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(17.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              border: Border.all(
                width: 1,
                color: const Color(0xFFBDDAFF),
              ),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Note: ',
                    style: TextStyle(
                      color: const Color(0xFF1B388E),
                      fontSize: 14.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w700,
                      height: 1.43,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Cryptocurrency compliance with Islamic finance principles is debated. Consult with Islamic scholars for guidance on crypto investments.',
                    style: TextStyle(
                      color: const Color(0xFF1B388E),
                      fontSize: 14.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
