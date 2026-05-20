import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/notifications/presentation/screens/notifications_screen.dart';
import 'stock_search_bar.dart'; // make sure to import the search bar
import 'package:saifsyn/core/localization/localization_service.dart';

class StocksHeader extends StatelessWidget {
  const StocksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF00008B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Column(
        children: [
          // Title + Favorite & Notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Text(
                localizationService.translate('browseStocks'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),

              // Favorite & Notification Icons
              Row(
                children: [
                  // Favorite Icon
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0000BF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star_border,
                      color: Colors.amber,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Notification Badge
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0000BF),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              {Get.to(() => const NotificationsScreen())},
                          child: Center(
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 4.w,
                          top: 4.h,
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
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Search Bar
          const StockSearchBar(),
        ],
      ),
    );
  }
}
