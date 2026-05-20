import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisclaimerCard extends StatelessWidget {
  const DisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(21.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: Border.all(
          width: 1,
          color: const Color(0xFFBDDAFF),
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Disclaimer: ',
              style: TextStyle(
                color: const Color(0xFF1B388E),
                fontSize: 14.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w700,
                height: 1.43,
              ),
            ),
            TextSpan(
              text:
                  'These recommendations are based on analysis and research. Past performance does not guarantee future results. Always conduct your own research before investing.',
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
