import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinancialRecordActions extends StatelessWidget {
  const FinancialRecordActions({
    super.key,
    required this.isSubmitting,
    required this.onEdit,
    required this.onDelete,
    required this.onView,
  });

  final bool isSubmitting;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: isSubmitting ? null : onEdit,
          icon: Icon(
            Icons.edit_outlined,
            color: const Color(0xFF2563EB),
            size: 18.sp,
          ),
          splashRadius: 18.r,
          tooltip: 'Edit',
        ),
        IconButton(
          onPressed: isSubmitting ? null : onDelete,
          icon: Icon(
            Icons.delete_outline_rounded,
            color: const Color(0xFFDC2626),
            size: 18.sp,
          ),
          splashRadius: 18.r,
          tooltip: 'Delete',
        ),
        IconButton(
          onPressed: onView,
          icon: Icon(
            Icons.remove_red_eye_outlined,
            color: const Color(0xFF1D4ED8),
            size: 18.sp,
          ),
          splashRadius: 18.r,
          tooltip: 'View',
        ),
      ],
    );
  }
}
