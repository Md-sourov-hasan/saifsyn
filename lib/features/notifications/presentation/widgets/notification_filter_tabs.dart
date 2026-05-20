import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class NotificationFilterTabs extends StatelessWidget {
  final int totalCount;
  final int unreadCount;
  final bool showUnreadOnly;
  final ValueChanged<bool> onFilterChanged;
  final VoidCallback? onClearAll;

  const NotificationFilterTabs({
    super.key,
    required this.totalCount,
    required this.unreadCount,
    this.showUnreadOnly = false,
    required this.onFilterChanged,
    this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      height: 43.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: const Color(0xFFE5E7EB),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Filter tabs
          Row(
            children: [
              // All tab
              GestureDetector(
                onTap: () => onFilterChanged(false),
                child: Text(
                  '${localizationService.translate('allNotifications')} ($totalCount)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !showUnreadOnly
                        ? const Color(0xFF101727)
                        : const Color(0xFF495565),
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    fontWeight:
                        !showUnreadOnly ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(width: 24.w),

              // Unread tab
              GestureDetector(
                onTap: () => onFilterChanged(true),
                child: Text(
                  '${localizationService.translate('unreadNotifications')} ($unreadCount)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: showUnreadOnly
                        ? const Color(0xFF101727)
                        : const Color(0xFF495565),
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    fontWeight:
                        showUnreadOnly ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),

          // Clear All button
          GestureDetector(
            onTap: onClearAll,
            child: Text(
              localizationService.translate('clearAll'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
