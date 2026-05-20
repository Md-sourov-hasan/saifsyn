import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StockStatusBadge extends StatelessWidget {
  final String status;

  const StockStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final normalized = status.toUpperCase();

    List<Color> gradientColors;
    Color glowColor;

    switch (normalized) {
      case 'COMPLIANT':
        gradientColors = const [Color(0xFF0D9F6E), Color(0xFF0CCB86)];
        glowColor = const Color(0xFF0FBE82);
        break;
      case 'NON_COMPLIANT':
        gradientColors = const [Color(0xFFD24141), Color(0xFFEF5E5E)];
        glowColor = const Color(0xFFE35353);
        break;
      case 'QUESTIONABLE':
        gradientColors = const [Color(0xFFCD8A14), Color(0xFFF4AF24)];
        glowColor = const Color(0xFFE8A326);
        break;
      default:
        gradientColors = const [Color(0xFF627287), Color(0xFF8698AD)];
        glowColor = const Color(0xFF7D8EA3);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(100.r),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: 0.34),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.92),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            normalized.replaceAll('_', ' '),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.15,
            ),
          ),
        ],
      ),
    );
  }
}
