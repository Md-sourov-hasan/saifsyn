import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Attachment Button
          GestureDetector(
            onTap: () {
              // TODO: Handle attachment action
            },
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(33554400.r),
              ),
              child: Center(
                child: Icon(
                  Icons.attach_file,
                  size: 20.sp,
                  color: const Color(0xFF697282),
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Text Input Field
          Expanded(
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFE5E7EB),
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF697282),
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                style: TextStyle(
                  color: const Color(0xFF101727),
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Send Button
          GestureDetector(
            onTap: () {
              // TODO: Handle send message action
            },
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(33554400.r),
              ),
              child: Center(
                child: Icon(
                  Icons.send,
                  size: 20.sp,
                  color: const Color(0xFF697282),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
