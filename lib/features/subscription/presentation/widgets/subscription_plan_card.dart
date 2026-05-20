import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String? savingsText;
  final String? pricePerMonth;
  final bool isSelected;
  final bool isSubscribed;
  final VoidCallback? onTap;

  const SubscriptionPlanCard({
    super.key,
    required this.title,
    required this.price,
    this.savingsText,
    this.pricePerMonth,
    this.isSelected = false,
    this.isSubscribed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(17.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0x0C00008B) : Colors.white,
          border: Border.all(
            width: 1.11,
            color:
                isSelected ? const Color(0xFF00008B) : const Color(0xFFE5E7EB),
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side - Title and savings
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF101727),
                    fontSize: 16.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
                if (savingsText != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    savingsText!,
                    style: TextStyle(
                      color: const Color(0xFF00008B),
                      fontSize: 14.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
                if (isSubscribed) ...[
                  SizedBox(height: 6.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(999.r),
                      border: Border.all(color: const Color(0xFF16A34A)),
                    ),
                    child: Text(
                      'Already Subscribed',
                      style: TextStyle(
                        color: const Color(0xFF166534),
                        fontSize: 12.sp,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Right side - Price and per month
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: const Color(0xFF101727),
                    fontSize: 24.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                if (pricePerMonth != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    pricePerMonth!,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(0xFF697282),
                      fontSize: 14.sp,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
