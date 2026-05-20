import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinancialTabContent extends StatelessWidget {
  const FinancialTabContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.addButtonLabel,
    required this.isSubmitting,
    required this.onAdd,
    required this.onRefresh,
    required this.isLoading,
    required this.isEmpty,
    required this.emptyMessage,
    required this.table,
  });

  final String title;
  final String subtitle;
  final String addButtonLabel;
  final bool isSubmitting;
  final VoidCallback onAdd;
  final Future<void> Function() onRefresh;
  final bool isLoading;
  final bool isEmpty;
  final String emptyMessage;
  final Widget table;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF111827),
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 44.h,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : onAdd,
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: const Color(0xFF00008B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  addButtonLabel,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(
              Icons.auto_awesome,
              size: 18.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: isLoading && isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 120.h),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  )
                : isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 80.h),
                          Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.inbox_rounded,
                                  size: 42.sp,
                                  color: const Color(0xFF9CA3AF),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  emptyMessage,
                                  style: TextStyle(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : table,
          ),
        ),
      ],
    );
  }
}
