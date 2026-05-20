import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoNoteCard extends StatelessWidget {
  final String title;
  final String message;

  const InfoNoteCard({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: Border.all(
          width: 1.11,
          color: const Color(0xFFBDDAFF),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title ',
              style: TextStyle(
                color: const Color(0xFF1B388E),
                fontSize: 14.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                height: 1.43,
              ),
            ),
            TextSpan(
              text: message,
              style: TextStyle(
                color: const Color(0xFF1B388E),
                fontSize: 14.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
