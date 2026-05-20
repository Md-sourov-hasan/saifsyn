import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInputField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final IconData? icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;

  const ProfileInputField({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.controller,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF354152),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(height: 8.h),

        // Input field
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.11,
              color: const Color(0xFFD0D5DB),
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextFormField(
            controller: controller,
            initialValue: controller == null ? initialValue : null,
            keyboardType: keyboardType,
            maxLines: maxLines,
            readOnly: readOnly,
            onTap: onTap,
            style: TextStyle(
              color: const Color(0xFF0A0A0A),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: const Color(0x7F0A0A0A),
                fontSize: 16.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                icon,
                size: 20.sp,
                color: const Color(0xFF354152),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
