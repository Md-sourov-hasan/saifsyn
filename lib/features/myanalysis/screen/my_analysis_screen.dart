import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/analysis_details/screen/analysis_details_screen.dart';
import 'package:saifsyn/features/main/controllers/main_navigation_controller.dart';
import 'package:saifsyn/features/myanalysis/widgets/search_field_widgets.dart';
import 'package:saifsyn/features/myanalysis/widgets/stock_card_widgets.dart';
import '../controller/my_analysis_controller.dart';

class MyAnalysisScreen extends StatelessWidget {
  const MyAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalysisController());

    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      body: SafeArea(
        child: Column(
          children: [
            _HeaderSection(controller: controller),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isLoading && controller.filteredStocks.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty &&
                    controller.filteredStocks.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.errorMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: controller.fetchAnalyses,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (controller.filteredStocks.isEmpty) {
                  return const Center(
                    child: Text(
                      'No analyses found',
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.fetchAnalyses,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.filteredStocks.length,
                    itemBuilder: (context, index) {
                      final stock = controller.filteredStocks[index];
                      return StockCardWidget(
                        stock: stock,
                        onTap: () => Get.to(
                          () => const AnalysisDetailsScreen(),
                          arguments: stock,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final AnalysisController controller;

  const _HeaderSection({required this.controller});

  void _handleBack(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }

    if (Get.isRegistered<MainNavigationController>()) {
      Get.find<MainNavigationController>().goToPreviousTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xff0A0A8F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _handleBack(context),
            behavior: HitTestBehavior.opaque,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 6),
                Text(
                  "Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Browse Analysis",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SearchFieldWidget(
            onChanged: controller.updateSearchQuery,
          ),
        ],
      ),
    );
  }
}
