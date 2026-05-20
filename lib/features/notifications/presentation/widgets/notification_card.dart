import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String message;
  final String timeAgo;
  final bool isUnread;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.title,
    required this.message,
    required this.timeAgo,
    this.isUnread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: const Color(0xFFD6D6D6),
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 5,
              offset: Offset(0, 0),
              spreadRadius: -1,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Left blue border for unread notifications
            if (isUnread)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00008B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100.r),
                      bottomLeft: Radius.circular(100.r),
                    ),
                  ),
                ),
              ),
            // Content
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 20.sp,
                      color: isUnread
                          ? const Color(0xFF00008B)
                          : const Color(0xFF495565),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and unread indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: const Color(0xFF101727),
                                  fontSize: 18.sp,
                                  fontFamily: 'Arial',
                                  fontWeight: isUnread
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00008B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: 4.h),

                        // Message
                        Text(
                          message,
                          style: TextStyle(
                            color: const Color(0xFF495565),
                            fontSize: 14.sp,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 4.h),

                        // Time ago
                        Text(
                          timeAgo,
                          style: TextStyle(
                            color: const Color(0xFF99A1AE),
                            fontSize: 12.sp,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
