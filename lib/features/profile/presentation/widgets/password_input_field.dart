import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? helperText;
  final String? Function(String?)? validator;

  const PasswordInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.helperText,
    this.validator,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            color: const Color(0xFF354152),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(height: 8.h),

        // Password field
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.11,
              color: const Color(0xFFD0D5DB),
            ),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            validator: widget.validator,
            style: TextStyle(
              color: const Color(0xFF0A0A0A),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: const Color(0x7F0A0A0A),
                fontSize: 16.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 20.sp,
                color: const Color(0xFF354152),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 20.sp,
                  color: const Color(0xFF354152),
                ),
                onPressed: _toggleVisibility,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),

        // Helper text
        if (widget.helperText != null) ...[
          SizedBox(height: 4.h),
          Text(
            widget.helperText!,
            style: TextStyle(
              color: const Color(0xFF697282),
              fontSize: 14.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
