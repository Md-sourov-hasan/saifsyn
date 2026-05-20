import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class HalalComplianceChart extends StatelessWidget {
  final double halalPercentage;
  final double doubtfulPercentage;
  final double notHalalPercentage;

  const HalalComplianceChart({
    super.key,
    this.halalPercentage = 95.96,
    this.doubtfulPercentage = 0.0,
    this.notHalalPercentage = 4.04,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Column(
      children: [
        // Pie Chart
        SizedBox(
          height: 192.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pie Chart
              SizedBox(
                width: 192.w,
                height: 192.h,
                child: CustomPaint(
                  painter: HalalPieChartPainter(
                    halalPercentage: halalPercentage,
                    doubtfulPercentage: doubtfulPercentage,
                    notHalalPercentage: notHalalPercentage,
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              // Legend
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(
                    localizationService.translate('halal'),
                    '${halalPercentage.toStringAsFixed(2)}%',
                    const Color(0xFF00008B),
                  ),
                  SizedBox(height: 9.h),
                  _buildLegendItem(
                    localizationService.translate('doubtful'),
                    '${doubtfulPercentage.toStringAsFixed(2)}%',
                    const Color(0xE0FFAE18),
                  ),
                  SizedBox(height: 9.h),
                  _buildLegendItem(
                    localizationService.translate('notHalal'),
                    '${notHalalPercentage.toStringAsFixed(2)}%',
                    const Color(0xFFE7000B),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Description text
        SizedBox(
          width: 333.w,
          child: Text(
            localizationService.translate('halalComplianceDescription'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF697282),
              fontSize: 11.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.82,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 43.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7.r),
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              percentage,
              style: TextStyle(
                color: const Color(0xFF697282),
                fontSize: 12.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HalalPieChartPainter extends CustomPainter {
  final double halalPercentage;
  final double doubtfulPercentage;
  final double notHalalPercentage;

  HalalPieChartPainter({
    required this.halalPercentage,
    required this.doubtfulPercentage,
    required this.notHalalPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Calculate angles
    final total = halalPercentage + doubtfulPercentage + notHalalPercentage;
    final halalAngle = (halalPercentage / total) * 2 * math.pi;
    final doubtfulAngle = (doubtfulPercentage / total) * 2 * math.pi;
    final notHalalAngle = (notHalalPercentage / total) * 2 * math.pi;

    // Draw Halal segment (blue)
    final halalPaint = Paint()
      ..color = const Color(0xFF00008B)
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      halalAngle,
      true,
      halalPaint,
    );

    // Draw Doubtful segment (orange) - if exists
    if (doubtfulPercentage > 0) {
      final doubtfulPaint = Paint()
        ..color = const Color(0xE0FFAE18)
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + halalAngle,
        doubtfulAngle,
        true,
        doubtfulPaint,
      );
    }

    // Draw Not Halal segment (red) - if exists
    if (notHalalPercentage > 0) {
      final notHalalPaint = Paint()
        ..color = const Color(0xFFE7000B)
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + halalAngle + doubtfulAngle,
        notHalalAngle,
        true,
        notHalalPaint,
      );
    }

    // Draw white center circle (donut effect)
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  @override
  bool shouldRepaint(HalalPieChartPainter oldDelegate) {
    return oldDelegate.halalPercentage != halalPercentage ||
        oldDelegate.doubtfulPercentage != doubtfulPercentage ||
        oldDelegate.notHalalPercentage != notHalalPercentage;
  }
}
