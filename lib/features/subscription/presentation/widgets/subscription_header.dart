import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:saifsyn/features/notifications/presentation/screens/notifications_screen.dart';

class SubscriptionHeader extends StatelessWidget {
  final int notificationCount;

  const SubscriptionHeader({
    super.key,
    this.notificationCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF00008B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 5.w),
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
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizationService.translate('subscription'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0000BF),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              {Get.to(() => const NotificationsScreen())},
                          child: Center(
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        if (notificationCount > 0)
                          Positioned(
                            right: 6.w,
                            top: 6.h,
                            child: Container(
                              width: 12.w,
                              height: 12.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFB2C36),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '$notificationCount',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.sp,
                                    fontFamily: 'Arial',
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
              SizedBox(height: 7.h),
              Text(
                localizationService.translate('managePlansBilling'),
                style: TextStyle(
                  color: const Color(0xD1EDEDED),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
