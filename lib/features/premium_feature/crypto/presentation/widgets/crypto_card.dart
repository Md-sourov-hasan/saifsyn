import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoCard extends StatelessWidget {
  final String symbol;
  final String name;
  final String price;
  final String marketCap;
  final String changePercent;
  final bool isPositive;

  const CryptoCard({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.marketCap,
    required this.changePercent,
    required this.isPositive,
  });

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
          // Header row (symbol + badge | change %)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side (symbol + badge + name)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        symbol,
                        style: TextStyle(
                          color: const Color(0xFF101727),
                          fontSize: 20.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE2E2),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Text(
                          'HIGH RISK',
                          style: TextStyle(
                            color: const Color(0xFFC10007),
                            fontSize: 10.sp,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                            height: 1.60,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    name,
                    style: TextStyle(
                      color: const Color(0xFF697282),
                      fontSize: 16.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
              ),

              // Right side (change %)
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    size: 20.sp,
                    color: isPositive
                        ? const Color(0xFF00008B)
                        : const Color(0xFFE7000B),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    changePercent,
                    style: TextStyle(
                      color: isPositive
                          ? const Color(0xFF00008B)
                          : const Color(0xFFE7000B),
                      fontSize: 16.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Price and Market Cap row
          Row(
            children: [
              // Price column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        color: const Color(0xFF697282),
                        fontSize: 14.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      price,
                      style: TextStyle(
                        color: const Color(0xFF101727),
                        fontSize: 20.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
              ),

              // Market Cap column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Market Cap',
                      style: TextStyle(
                        color: const Color(0xFF697282),
                        fontSize: 14.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      marketCap,
                      style: TextStyle(
                        color: const Color(0xFF101727),
                        fontSize: 20.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
