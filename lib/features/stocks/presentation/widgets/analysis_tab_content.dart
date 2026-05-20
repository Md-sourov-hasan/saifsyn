import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:saifsyn/core/utils/constants/image_path.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class AnalysisTabContent extends StatelessWidget {
  const AnalysisTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    // Rating data
    // const ratings = {
    //   'Strong Buy': 19,
    //   'Buy': 27,
    //   'Hold': 42,
    //   'Sell': 12,
    //   'Strong Sell': 0,
    // };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizationService.translate('analystRatingsTitle'),
          style: TextStyle(
            color: const Color(0xFF101727),
            fontSize: 16.sp,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 11.h),
        SizedBox(
          width: 328.w,
          child: Text(
            localizationService.translate('analystRatingsSubtitle'),
            style: TextStyle(
              color: const Color(0xFF909090),
              fontSize: 15.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),
        SizedBox(height: 24.h),

        Image.asset(
          ImagePath.analystRatingGauge,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 24.h),

        // Rating bars
        _buildRatingBar(localizationService.translate('strongBuy'), 19, 100),
        SizedBox(height: 12.h),
        _buildRatingBar(localizationService.translate('buy'), 27, 100),
        SizedBox(height: 12.h),
        _buildRatingBar(localizationService.translate('hold'), 42, 100),
        SizedBox(height: 12.h),
        _buildRatingBar(localizationService.translate('sell'), 12, 100),
        SizedBox(height: 12.h),
        _buildRatingBar(localizationService.translate('strongSell'), 0, 100),
      ],
    );
  }

  Widget _buildRatingBar(String label, int count, int maxCount) {
    final percentage = count / maxCount;

    return Row(
      children: [
        SizedBox(
          width: 78.w,
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF99A1AF),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 9.w),
        Expanded(
          child: Stack(
            children: [
              // Background bar
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(129.r),
                ),
              ),
              // Filled bar
              FractionallySizedBox(
                widthFactor: percentage > 0 ? percentage : 0.44,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00008B),
                    borderRadius: BorderRadius.circular(129.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 9.w),
        SizedBox(
          width: 24.w,
          child: Text(
            count.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF99A1AF),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class AnalystRatingGauge extends StatelessWidget {
  final Map<String, int> ratings;

  const AnalystRatingGauge({
    super.key,
    required this.ratings,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return SizedBox(
      height: 200.h,
      child: Stack(
        children: [
          // Gauge chart
          Positioned(
            left: 43.w,
            top: 0,
            child: SizedBox(
              width: 260.w,
              height: 260.h,
              child: CustomPaint(
                painter: AnalystRatingGaugePainter(ratings: ratings),
              ),
            ),
          ),
          // Strong Sell label (bottom left)
          Positioned(
            left: 35.w,
            top: 142.h,
            child: Text(
              localizationService.translate('strongSell'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Sell label (left)
          Positioned(
            left: 35.w,
            top: 11.h,
            child: Text(
              localizationService.translate('sell'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Hold label (top center)
          Positioned(
            left: 150.w,
            top: 0.h,
            child: Text(
              localizationService.translate('hold'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Buy label (right)
          Positioned(
            left: 263.w,
            top: 0,
            child: Text(
              localizationService.translate('buy'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Strong Buy label (bottom right)
          Positioned(
            left: 246.w,
            top: 137.h,
            child: SizedBox(
              width: 78.w,
              child: Text(
                localizationService.translate('strongBuy'),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnalystRatingGaugePainter extends CustomPainter {
  final Map<String, int> ratings;

  AnalystRatingGaugePainter({required this.ratings});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Calculate total ratings
    final total = ratings.values.fold(0, (sum, value) => sum + value);
    if (total == 0) return;

    // Calculate angles for each segment (semicircle from left to right)
    // Start from PI (left) and go to 2*PI (right) = PI radians total
    final startAngle = math.pi; // Start from left (180 degrees)
    final totalAngle = math.pi; // Semicircle (180 degrees)

    double currentAngle = startAngle;

    // Draw segments in order: Strong Sell, Sell, Hold, Buy, Strong Buy
    final orderedRatings = [
      ('Strong Sell', ratings['Strong Sell'] ?? 0),
      ('Sell', ratings['Sell'] ?? 0),
      ('Hold', ratings['Hold'] ?? 0),
      ('Buy', ratings['Buy'] ?? 0),
      ('Strong Buy', ratings['Strong Buy'] ?? 0),
    ];

    // Colors for different segments
    final colors = [
      const Color(0xFF00008B), // Strong Sell - Dark Blue
      const Color(0xFF00008B), // Sell - Dark Blue
      const Color(0xFF00008B), // Hold - Dark Blue
      const Color(0xFFD9D9D9), // Buy - Light Gray
      const Color(0xFFD9D9D9), // Strong Buy - Light Gray
    ];

    // Draw each segment
    for (int i = 0; i < orderedRatings.length; i++) {
      final rating = orderedRatings[i];
      final count = rating.$2;
      final segmentAngle = (count / total) * totalAngle;

      if (count > 0) {
        final paint = Paint()
          ..color = colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 60
          ..strokeCap = StrokeCap.butt;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius - 30),
          currentAngle,
          segmentAngle,
          false,
          paint,
        );

        currentAngle += segmentAngle;
      }
    }

    // Calculate needle position based on Hold rating (42 out of 100)
    // Hold is in the middle, so we need to point to its section
    final holdPosition = (ratings['Strong Sell'] ?? 0) +
        (ratings['Sell'] ?? 0) +
        ((ratings['Hold'] ?? 0) / 2);
    final needleAngle = startAngle + (holdPosition / total) * totalAngle;

    // Draw needle
    final needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final needleLength = radius - 30;
    final needleEnd = Offset(
      center.dx + needleLength * math.cos(needleAngle),
      center.dy + needleLength * math.sin(needleAngle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);

    // Draw center circle
    final centerCirclePaint = Paint()
      ..color = const Color(0xFF00008B)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 7, centerCirclePaint);
  }

  @override
  bool shouldRepaint(AnalystRatingGaugePainter oldDelegate) {
    return oldDelegate.ratings != ratings;
  }
}
