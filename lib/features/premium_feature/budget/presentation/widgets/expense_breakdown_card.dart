import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class ExpenseBreakdownCard extends StatelessWidget {
  const ExpenseBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFD6D6D6),
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Breakdown',
            style: TextStyle(
              color: const Color(0xFF00008B),
              fontSize: 20.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          // SizedBox(height: 16.h),
          SizedBox(
            height: 250.h,
            child: Center(
              child: CustomPaint(
                size: Size(200.w, 200.h),
                painter: PieChartPainter(),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    final categories = [
      {'label': 'Entertainment', 'color': const Color(0xFFEC4899)},
      {'label': 'Food', 'color': const Color(0xFF3B82F6)},
      {'label': 'Healthcare', 'color': const Color(0xFF06B6D4)},
      {'label': 'Housing', 'color': const Color(0xFF10B981)},
      {'label': 'Other', 'color': const Color(0xFF6B7280)},
      {'label': 'Transport', 'color': const Color(0xFFF59E0B)},
      {'label': 'Utilities', 'color': const Color(0xFF8B5CF6)},
    ];

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.w,
        runSpacing: 8.h,
        children: categories.map((category) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14.w,
                height: 14.w,
                color: category['color'] as Color,
              ),
              SizedBox(width: 6.w),
              Text(
                category['label'] as String,
                style: TextStyle(
                  color: category['color'] as Color,
                  fontSize: 16.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final expenses = [
      {'value': 2000.0, 'color': const Color(0xFF10B981)}, // Housing 38.2%
      {'value': 800.0, 'color': const Color(0xFF3B82F6)}, // Food 15.3%
      {'value': 500.0, 'color': const Color(0xFFEC4899)}, // Entertainment 9.5%
      {'value': 500.0, 'color': const Color(0xFF6B7280)}, // Other 9.5%
      {'value': 400.0, 'color': const Color(0xFFF59E0B)}, // Transport 7.6%
      {'value': 300.0, 'color': const Color(0xFF8B5CF6)}, // Utilities 5.7%
      {'value': 240.0, 'color': const Color(0xFF06B6D4)}, // Healthcare 4.6%
    ];

    final total = expenses.fold<double>(
        0, (sum, item) => sum + (item['value'] as double));
    double startAngle = -math.pi / 2;

    for (final expense in expenses) {
      final sweepAngle = 2 * math.pi * (expense['value'] as double) / total;
      final paint = Paint()
        ..color = expense['color'] as Color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }

    // Draw center white circle
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.4, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
