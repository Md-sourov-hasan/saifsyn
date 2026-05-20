import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isUserMessage;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 276.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isUserMessage ? const Color(0xFF00008B) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isUserMessage
              ? []
              : [
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
            Text(
              message,
              style: TextStyle(
                color: isUserMessage ? Colors.white : const Color(0xFF101727),
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
                color: isUserMessage
                    ? const Color(0xFFD0FAE4)
                    : const Color(0xFF697282),
                fontSize: 12.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
