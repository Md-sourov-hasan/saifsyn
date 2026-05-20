import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HighlightedStockCard extends StatelessWidget {
  final String symbol;
  final String companyName;
  final String status;

  const HighlightedStockCard({
    super.key,
    required this.symbol,
    required this.companyName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedStatus = status.toUpperCase();
    final chipColor = _chipColor(normalizedStatus);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A0CB6), Color(0xFF1219CF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 2.h,
            right: 0,
            child: Icon(
              Icons.north_east_rounded,
              size: 86.sp,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _StatusChip(
                    text: normalizedStatus.replaceAll('_', ' '),
                    color: chipColor,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.trending_up_rounded,
                    size: 22.sp,
                    color: Colors.white.withValues(alpha: 0.82),
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Text(
                symbol.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  letterSpacing: 0.35,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                companyName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFFA6B2FF),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 18.h),
              const _MiniBarChart(),
            ],
          ),
        ],
      ),
    );
  }

  Color _chipColor(String normalizedStatus) {
    switch (normalizedStatus) {
      case 'COMPLIANT':
        return const Color(0xFF51F5B0);
      case 'NON COMPLIANT':
      case 'NON_COMPLIANT':
        return const Color(0xFFFF8F8F);
      case 'QUESTIONABLE':
        return const Color(0xFFFFD56E);
      default:
        return const Color(0xFFC8D1FF);
    }
  }
}

class _StatusChip extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusChip({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: color.withValues(alpha: 0.40)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.55,
        ),
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart();

  @override
  Widget build(BuildContext context) {
    final barHeights = [20.0, 28.0, 24.0, 40.0, 34.0, 58.0, 78.0];

    return SizedBox(
      height: 82.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(barHeights.length, (index) {
          final isLast = index == barHeights.length - 1;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  right: index == barHeights.length - 1 ? 0 : 6.w),
              child: Container(
                height: barHeights[index].h,
                decoration: BoxDecoration(
                  color: isLast
                      ? const Color(0xFFA8B2FF).withValues(alpha: 0.62)
                      : const Color(0xFF8A94E7).withValues(alpha: 0.46),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.r),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
