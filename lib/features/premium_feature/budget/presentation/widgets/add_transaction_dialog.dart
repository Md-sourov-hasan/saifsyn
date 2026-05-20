import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddTransactionDialog extends StatelessWidget {
  final bool isIncome;
  const AddTransactionDialog({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isIncome ? 'Add Income' : 'Add Expense',
                  style: TextStyle(
                    color: const Color(0xFF101727),
                    fontSize: 20.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, size: 22.sp),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Source / Category Field
            _InputField(
              label: isIncome ? 'Source' : 'Category',
              hint:
                  isIncome ? 'e.g., Salary, Freelance' : 'e.g., Food, Housing',
            ),

            SizedBox(height: 16.h),

            // Amount Field
            _InputField(
                label: 'Amount',
                hint: '0.00',
                keyboardType: TextInputType.number),

            SizedBox(height: 24.h),

            // Add Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: isIncome
                      ? const Color(0xFF00008B)
                      : const Color(0xFFE7000B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO: Save transaction
                  Get.back();
                },
                child: Text(
                  isIncome ? 'Add Income' : 'Add Expense',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF354152),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: const Color(0x7F0A0A0A),
              fontSize: 16.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(color: Color(0xFFD0D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
                  color: keyboardType == TextInputType.number
                      ? const Color(0xFFE7000B)
                      : const Color(0xFF00008B)),
            ),
          ),
        ),
      ],
    );
  }
}
