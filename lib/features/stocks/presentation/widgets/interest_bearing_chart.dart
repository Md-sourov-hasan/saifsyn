import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class InterestBearingChart extends StatelessWidget {
  final double compliancePercentage;
  final double nonCompliancePercentage;

  const InterestBearingChart({
    super.key,
    this.compliancePercentage = 95.96,
    this.nonCompliancePercentage = 4.04,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gauge Chart and Legend Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gauge Chart
            SizedBox(
              height: 120.h,
              width: 160.w,
              child: CustomPaint(
                painter: InterestBearingGaugePainter(
                  compliancePercentage: compliancePercentage,
                  nonCompliancePercentage: nonCompliancePercentage,
                ),
              ),
            ),

            SizedBox(width: 24.w),

            // Legend
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(
                    Get.find<LocalizationService>()
                        .translate('shariahCompliant'),
                    Get.find<LocalizationService>().translate('lessThan30'),
                    const Color(0xFFFF9BA5),
                  ),
                  SizedBox(height: 16.h),
                  _buildLegendItem(
                    Get.find<LocalizationService>()
                        .translate('nonShariahCompliant'),
                    Get.find<LocalizationService>().translate('greaterThan30'),
                    const Color(0xFFFF4D5E),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 24.h),

        // Description text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Text(
            Get.find<LocalizationService>()
                .translate('interestBearingDescription'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF697282),
              fontSize: 11.sp,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, String description, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(width: 12.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF101727),
                  fontSize: 13.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: TextStyle(
                  color: const Color(0xFF697282),
                  fontSize: 11.sp,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InterestBearingGaugePainter extends CustomPainter {
  final double compliancePercentage;
  final double nonCompliancePercentage;

  InterestBearingGaugePainter({
    required this.compliancePercentage,
    required this.nonCompliancePercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.85);
    final radius = size.width * 0.38;

    // Draw background arc (light gray)
    final backgroundPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Calculate the angle for the compliance segment
    final total = compliancePercentage + nonCompliancePercentage;
    final complianceAngle = (compliancePercentage / total) * math.pi;

    // Draw compliance segment (light pink)
    final compliancePaint = Paint()
      ..color = const Color(0xFFFF9BA5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      complianceAngle,
      false,
      compliancePaint,
    );

    // Draw non-compliance segment (dark red)
    if (nonCompliancePercentage > 0) {
      final nonCompliancePaint = Paint()
        ..color = const Color(0xFFFF4D5E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 24
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi + complianceAngle,
        (nonCompliancePercentage / total) * math.pi,
        false,
        nonCompliancePaint,
      );
    }

    // Draw needle
    final needleAngle = math.pi + (nonCompliancePercentage / total) * math.pi;
    final needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final needleLength = radius;
    final needleEnd = Offset(
      center.dx + needleLength * math.cos(needleAngle),
      center.dy + needleLength * math.sin(needleAngle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw center circle
    final centerCirclePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 5, centerCirclePaint);

    // Draw percentage text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${nonCompliancePercentage.toStringAsFixed(2)}%',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'Arial',
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - radius * 0.5 - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(InterestBearingGaugePainter oldDelegate) {
    return oldDelegate.compliancePercentage != compliancePercentage ||
        oldDelegate.nonCompliancePercentage != nonCompliancePercentage;
  }
}
