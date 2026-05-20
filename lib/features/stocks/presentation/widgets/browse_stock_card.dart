import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class BrowseStockCard extends StatelessWidget {
  final String symbol;
  final String name;
  final String price;
  final String change;
  final bool isPositive;
  final String riskLevel;
  final String halalStatus;
  final bool isPrimary;

  const BrowseStockCard({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.isPositive,
    required this.riskLevel,
    required this.halalStatus,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return GestureDetector(
      onTap: () {
        // Navigate to stock details
        Get.toNamed(
          '/stock-details',
          arguments: {
            'symbol': symbol,
            'name': name,
            'price': price,
            'change': change,
            'isPositive': isPositive,
            'isHalalCertified': halalStatus == 'Halal',
            'riskLevel': '$riskLevel RISK',
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF00008B) : Colors.white,
          border: Border.all(
            color: const Color(0xFFDFDFDF),
            width: 1,
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
          children: [
            // Top Row - Symbol, Risk Badge, and Halal Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left - Symbol and Risk Badge
                Row(
                  children: [
                    Text(
                      symbol,
                      style: TextStyle(
                        color:
                            isPrimary ? Colors.white : const Color(0xFF101727),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: _getRiskColor(riskLevel),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Text(
                        // Map risk level token to a localization key
                        localizationService
                            .translate(_riskKeyFromValue(riskLevel)),
                        style: TextStyle(
                          color: _getRiskTextColor(riskLevel),
                          fontSize: 10.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),

                // Right - Halal Status
                Row(
                  children: [
                    Icon(
                      _getHalalIcon(),
                      color: _getHalalColor(),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      localizationService
                          .translate(_halalKeyFromValue(halalStatus)),
                      style: TextStyle(
                        color: isPrimary ? Colors.white : _getHalalColor(),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4.h),

            // Company Name
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: TextStyle(
                  color: isPrimary
                      ? const Color(0xFFE4E4E4)
                      : const Color(0xFF697282),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 8.h),

            // Bottom Row - Price and Change
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    color: isPrimary ? Colors.white : const Color(0xFF101727),
                    fontSize: 18.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      isPositive
                          ? ImagePath.upwardIcon
                          : ImagePath.downwardIcon,
                      width: 12.sp,
                      height: 12.sp,
                      color: isPrimary
                          ? const Color(0xFFC4C4C4)
                          : (isPositive
                              ? const Color(0xFF00008B)
                              : const Color(0xFFE7000B)),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      change,
                      style: TextStyle(
                        color: isPrimary
                            ? Colors.white
                            : (isPositive
                                ? const Color(0xFF00008B)
                                : const Color(0xFFE7000B)),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case 'LOW':
        return const Color(0xFFDCFCE7);
      case 'MEDIUM':
        return const Color(0xFFFEF9C2);
      case 'HIGH':
        return const Color(0xFFFFE2E2);
      default:
        return const Color(0xFFDCFCE7);
    }
  }

  Color _getRiskTextColor(String risk) {
    switch (risk) {
      case 'LOW':
        return const Color(0xFF008235);
      case 'MEDIUM':
        return const Color(0xFFA65F00);
      case 'HIGH':
        return const Color(0xFFC10007);
      default:
        return const Color(0xFF008235);
    }
  }

  Color _getHalalColor() {
    if (isPrimary) return Colors.white;
    switch (halalStatus) {
      case 'Halal':
        return const Color(0xFF00008B);
      case 'Doubtful':
        return const Color(0xFFD08700);
      case 'Haram':
        return const Color(0xFFE7000B);
      default:
        return const Color(0xFF00008B);
    }
  }

  IconData _getHalalIcon() {
    switch (halalStatus) {
      case 'Halal':
        return Icons.verified;
      case 'Doubtful':
        return Icons.help_outline;
      case 'Haram':
        return Icons.cancel_outlined;
      default:
        return Icons.verified;
    }
  }

  String _riskKeyFromValue(String risk) {
    final r = risk.toLowerCase();
    if (r.contains('low')) return 'lowRisk';
    if (r.contains('medium')) return 'mediumRisk';
    if (r.contains('high')) return 'highRisk';
    return risk;
  }

  String _halalKeyFromValue(String value) {
    final v = value.toLowerCase();
    if (v.contains('halal')) return 'halal';
    if (v.contains('doubt')) return 'doubtful';
    if (v.contains('haram') || v.contains('not')) return 'notHalal';
    return value;
  }
}
