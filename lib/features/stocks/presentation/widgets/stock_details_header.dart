import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class StockDetailsHeader extends StatelessWidget {
  final Map<String, dynamic> stockData;

  const StockDetailsHeader({
    super.key,
    required this.stockData,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = stockData['isPositive'] == true;
    final localizationService = Get.find<LocalizationService>();

    return SafeArea(
      bottom: false,
      child: Container(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, bottom: 4.h, top: 0.h),
        decoration: BoxDecoration(
          color: const Color(0xFF00008B),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        localizationService.translate('back'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                _NotificationIcon(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stockData['symbol'] ?? 'AAPL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      stockData['name'] ?? 'Apple Inc.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          stockData['price'] ?? '\$178.25',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          isPositive
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: const Color(0xFFC5C9C6),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          stockData['change'] ?? '+2.4%',
                          style: TextStyle(
                            color: const Color(0xFFC5C9C6),
                            fontSize: 10.sp,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.h),
                      height: 19.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Text(
                          localizationService.translate('halal'),
                          style: TextStyle(
                            color: const Color(0xFF008235),
                            fontSize: 8.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 2.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: const BoxDecoration(
        color: Color(0xFF0000BF),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => {Get.to(() => const NotificationsScreen())},
            child: Center(
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          Positioned(
            right: 8.w,
            top: 9.h,
            child: Container(
              width: 12.w,
              height: 12.h,
              decoration: const BoxDecoration(
                color: Color(0xFFFB2C36),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
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
