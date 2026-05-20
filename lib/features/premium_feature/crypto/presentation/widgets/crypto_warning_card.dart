import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoWarningCard extends StatelessWidget {
  const CryptoWarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFCE8),
        border: Border.all(
          width: 1,
          color: const Color(0xFFFEEF85),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: const Color(0xFFA65F00),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High Volatility Warning',
                  style: TextStyle(
                    color: const Color(0xFF723D0A),
                    fontSize: 16.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Cryptocurrencies are highly volatile. Only invest what you can afford to lose.',
                  style: TextStyle(
                    color: const Color(0xFFA65F00),
                    fontSize: 14.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
