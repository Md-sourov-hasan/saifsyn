import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saifsyn/core/utils/constants/image_path.dart';

class ForecastTabContent extends StatelessWidget {
  const ForecastTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ImagePath.priceForecastChart,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 24.h),
        Image.asset(
          ImagePath.revenueForecastChart,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 24.h),
        Image.asset(
          ImagePath.earningsForecastChart,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
