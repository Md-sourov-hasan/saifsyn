import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import 'package:fl_chart/fl_chart.dart';

class PriceActionChart extends StatelessWidget {
  final String price;
  final List<FlSpot> chartData;

  const PriceActionChart({
    super.key,
    required this.price,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
      width: double.infinity,
      height: 270.h,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: const Color(0xFFF0F4F9),
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Labels and Price widgets here...
          // Price label
          Text(
            localizationService.translate('priceAction'),
            style: TextStyle(
              color: const Color(0xFF0E162B),
              fontSize: 14.sp,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w700,
              height: 1.43,
              letterSpacing: 0.70,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            price,
            style: TextStyle(
              color: const Color(0xFF0E162B),
              fontSize: 18.sp,
              fontFamily: 'Arimo',
              fontWeight: FontWeight.w700,
              height: 1.33,
            ),
          ),
          SizedBox(height: 16.h),

          // Chart
          SizedBox(
            height: 160.h,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: Color(0xFF1D4ED8), width: 2),
                    bottom: BorderSide(color: Colors.transparent),
                  ),
                ),
                // This creates the dashed green baseline
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: 0, // Set this to your baseline value
                      color: const Color(0xFF10B981),
                      strokeWidth: 2,
                      dashArray: [5, 5],
                    ),
                  ],
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    barWidth: 3,
                    color: const Color(0xFF1D4ED8),
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF3B82F6).withOpacity(0.3),
                          const Color(0xFF3B82F6).withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
