import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StockOpportunityCard extends StatelessWidget {
  final String ticker;
  final String companyName;
  final String currentPrice;
  final String changePercent;
  final String upsidePotential;
  final String reason;
  final VoidCallback onViewDetails;

  const StockOpportunityCard({
    super.key,
    required this.ticker,
    required this.companyName,
    required this.currentPrice,
    required this.changePercent,
    required this.upsidePotential,
    required this.reason,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 3,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stock header (ticker, company name, price)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side (ticker + change)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        ticker,
                        style: TextStyle(
                          color: const Color(0xFF101727),
                          fontSize: 20.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 16.sp,
                            color: const Color(0xFF00008B),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            changePercent,
                            style: TextStyle(
                              color: const Color(0xFF00008B),
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
                  SizedBox(height: 4.h),
                  Text(
                    companyName,
                    style: TextStyle(
                      color: const Color(0xFF697282),
                      fontSize: 12.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),
                ],
              ),

              // Right side (price)
              Text(
                currentPrice,
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

          SizedBox(height: 16.h),

          // Upside potential box
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h),
            decoration: BoxDecoration(
              color: const Color(0x1E00008B),
              border: Border.all(
                width: 1,
                color: const Color(0xFF00008B),
              ),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.adjust_rounded,
                      size: 20.sp,
                      color: const Color(0xFF00008B),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Upside Potential: $upsidePotential',
                      style: TextStyle(
                        color: const Color(0xFF00008B),
                        fontSize: 16.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  reason,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // View Details button
          GestureDetector(
            onTap: onViewDetails,
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF00008B),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Text(
                  'View Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
