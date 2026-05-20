import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class RelatedNewsCard extends StatelessWidget {
  const RelatedNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Row(
            children: [
              Icon(
                Icons.newspaper,
                size: 20.sp,
                color: const Color(0xFF101727),
              ),
              SizedBox(width: 8.w),
              Text(
                localizationService.translate('relatedNews'),
                style: TextStyle(
                  color: const Color(0xFF101727),
                  fontSize: 16.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildNewsItem(
            localizationService,
            title: localizationService.translate('newsTitle1'),
            time: localizationService.translate('newsTime1'),
          ),
          SizedBox(height: 12.h),
          _buildNewsItem(
            localizationService,
            title: localizationService.translate('newsTitle2'),
            time: localizationService.translate('newsTime2'),
          ),
          SizedBox(height: 12.h),
          _buildNewsItem(
            localizationService,
            title: localizationService.translate('newsTitle3'),
            time: localizationService.translate('newsTime3'),
            showBorder: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(
    LocalizationService localizationService, {
    required String title,
    required String time,
    bool showBorder = true,
  }) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: showBorder
            ? Border.all(
                width: 1.11,
                color: const Color(0xFFF2F4F6),
              )
            : null,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
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
          SizedBox(height: 4.h),
          Text(
            time,
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
    );
  }
}
