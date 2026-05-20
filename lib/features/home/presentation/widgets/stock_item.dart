import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';

class StockItem extends StatelessWidget {
  final String symbol;
  final String name;
  final String price;
  final String change;
  final bool isPositive;
  final bool isPrimary;
  final String? halalStatus; // 'Halal' or 'Doubtful'
  final String? riskLevel; // 'Low Risk' or 'High Risk'

  const StockItem({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.isPositive,
    this.isPrimary = false,
    this.halalStatus,
    this.riskLevel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to stock details screen
        Get.toNamed(
          '/stock-details',
          arguments: {
            'symbol': symbol,
            'name': name,
            'price': price,
            'change': change,
            'isPositive': isPositive,
            'isHalalCertified': true,
            'riskLevel': 'LOW RISK',
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF00008B) : const Color(0xFFF9FAFB),
          border: Border.all(
            color: const Color(0xFFE5E4E4),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Symbol and Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        symbol,
                        style: TextStyle(
                          color: isPrimary
                              ? Colors.white
                              : const Color(0xFF101727),
                          fontSize: 16.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        name,
                        style: TextStyle(
                          color: isPrimary
                              ? const Color(0xFFD4D4D4)
                              : const Color(0xFF697282),
                          fontSize: 14.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                // Price and Change
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color:
                            isPrimary ? Colors.white : const Color(0xFF101727),
                        fontSize: 16.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          isPositive
                              ? ImagePath.upwardIcon
                              : ImagePath.downwardIcon,
                          width: 12.sp,
                          height: 12.sp,
                          color: isPrimary
                              ? const Color(0xFFC4C4C4)
                              : (isPositive
                                  ? const Color(0xFF00008B)
                                  : const Color(0xFFE7000B)),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          change,
                          style: TextStyle(
                            color: isPrimary
                                ? const Color(0xFFC4C4C4)
                                : (isPositive
                                    ? const Color(0xFF00008B)
                                    : const Color(0xFFE7000B)),
                            fontSize: 14.sp,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Halal and Risk Level Badges
            if (halalStatus != null || riskLevel != null) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  if (halalStatus != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: isPrimary ? Colors.white : Colors.white,
                        border: isPrimary
                            ? null
                            : Border.all(
                                color: const Color(0xFF00008B),
                                width: 0.1,
                              ),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        halalStatus!,
                        style: TextStyle(
                          color: const Color(0xFF00008B),
                          fontSize: 10.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  if (halalStatus != null && riskLevel != null)
                    SizedBox(width: 7.w),
                  if (riskLevel != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: isPrimary
                            ? Colors.white.withOpacity(0.28)
                            : const Color(0x47B6B6B6),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        riskLevel!,
                        style: TextStyle(
                          color: isPrimary
                              ? Colors.white
                              : const Color(0xFF7F7979),
                          fontSize: 10.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
