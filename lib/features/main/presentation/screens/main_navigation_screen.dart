import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:saifsyn/features/expense/presentation/finencial_manager/screens/ai_financial_dashbaord.dart';

import 'package:saifsyn/features/analysis/screen/analysis_screen.dart';
import 'package:saifsyn/features/portfolios/presentation/screens/portfolio_screen.dart';
import 'package:saifsyn/features/watchlist/presentation/whitchlist_dashboard.dart';
import '../../controllers/main_navigation_controller.dart';
import '../../../../core/common/widgets/custom_bottom_nav.dart';

import '../../../stocks/presentation/screens/stocks_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainNavigationController());

    final List<Widget Function()> screenBuilders = [
      () => const StocksScreen(),
      () => const WhatchlistDashboard(),
      () => const AnalysisScreen(),
      () => const AiFinancialDashbaord(),
      () => const ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: List.generate(screenBuilders.length, (index) {
            if (!controller.loadedTabs.contains(index)) {
              return const SizedBox.shrink();
            }
            return screenBuilders[index]();
          }),
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }
}
