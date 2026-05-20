import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommodityPriceCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String currentPrice;
  final String changePercent;
  final bool isPositive;
  final String unit;

  const CommodityPriceCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.changePercent,
    required this.isPositive,
    required this.unit,
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
          // Header row (name + change %)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side (name + symbol)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: const Color(0xFF101727),
                      fontSize: 20.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    symbol,
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

          // Price row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Left side (label + price)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Price',
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
                    currentPrice,
                    style: TextStyle(
                      color: const Color(0xFF101727),
                      fontSize: 24.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),

              // Right side (unit)
              Text(
                unit,
                style: TextStyle(
                  color: const Color(0xFF697282),
                  fontSize: 14.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
