import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/main/controllers/main_navigation_controller.dart';
import 'action_card.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionCard(
            icon: Icons.show_chart,
            iconColor: const Color(0xFF16A34A),
            backgroundColor: const Color(0xFFD0FAE5),
            title: 'Browse Stocks',
            description: 'Explore halal stocks',
            onTap: () {
              final controller = Get.find<MainNavigationController>();
              controller.changeTab(1);
            },
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ActionCard(
            icon: Icons.article_outlined,
            iconColor: const Color(0xFF2563EB),
            backgroundColor: const Color(0xFFDBEAFE),
            title: 'Latest News',
            description: 'Market updates',
            onTap: () {
              final controller = Get.find<MainNavigationController>();
              controller.changeTab(2);
            },
          ),
        ),
      ],
    );
  }
}
