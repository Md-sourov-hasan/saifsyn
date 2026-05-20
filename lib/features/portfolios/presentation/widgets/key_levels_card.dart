import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class KeyLevelsCard extends StatelessWidget {
  final String resistancePrice;
  final String supportPrice;

  const KeyLevelsCard({
    super.key,
    required this.resistancePrice,
    required this.supportPrice,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFF0F4F9),
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            localizationService.translate('keyLevels'),
            style: TextStyle(
              color: const Color(0xFF0E162B),
              fontSize: 14.sp,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w700,
              height: 1.43,
              letterSpacing: 0.70,
            ),
          ),

          SizedBox(height: 40.h),

          // Resistance and Support cards
          Row(
            children: [
              // Resistance
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 13.h,
                    left: 13.w,
                    right: 13.w,
                    bottom: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFFEE1E1),
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon + Label
                      Row(
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                  spreadRadius: -1,
                                ),
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_upward,
                                size: 12.sp,
                                color: const Color(0xFFC10007),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            localizationService.translate('resistance'),
                            style: TextStyle(
                              color: const Color(0xFFC10007),
                              fontSize: 12.sp,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                              height: 1.33,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      // Price
                      Text(
                        '\$$resistancePrice',
                        style: TextStyle(
                          color: const Color(0xFF0E162B),
                          fontSize: 18.sp,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w700,
                          height: 1.56,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              // Support
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 13.h,
                    left: 13.w,
                    right: 13.w,
                    bottom: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFD0FAE4),
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon + Label
                      Row(
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                  spreadRadius: -1,
                                ),
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_downward,
                                size: 12.sp,
                                color: const Color(0xFF007955),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            localizationService.translate('support'),
                            style: TextStyle(
                              color: const Color(0xFF007955),
                              fontSize: 12.sp,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                              height: 1.33,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      // Price
                      Text(
                        '\$$supportPrice',
                        style: TextStyle(
                          color: const Color(0xFF0E162B),
                          fontSize: 18.sp,
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.w700,
                          height: 1.56,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
