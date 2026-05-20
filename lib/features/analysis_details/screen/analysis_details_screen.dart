import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/analysis_details/controller/analysis_details_controller.dart';
import 'package:saifsyn/features/analysis_details/widgets/analysis_details_widgets.dart';
import 'package:saifsyn/features/main/controllers/main_navigation_controller.dart';
import 'package:saifsyn/features/stocks/controllers/stock_details_controller.dart';

class AnalysisDetailsScreen extends StatelessWidget {
  const AnalysisDetailsScreen({super.key});

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
    final controller = Get.put(AnalysisDetailsController());
    final stockDetailsController = Get.isRegistered<StockDetailsController>()
        ? Get.find<StockDetailsController>()
        : Get.put(StockDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      body: SafeArea(
        child: Obx(() {
          final analysis = controller.analysis;
          if (analysis == null) {
            return const Center(
              child: Text(
                'No analysis data found.',
                style: TextStyle(color: Colors.black54),
              ),
            );
          }

          return Column(
            children: [
              Obx(
                () => AnalysisDetailsHeaderWidget(
                  onBackTap: () => _handleBack(context),
                  onFavoriteTap: () {
                    stockDetailsController.toggleWishlistForSymbol(
                      controller.symbol,
                    );
                  },
                  symbol: controller.symbol,
                  name: controller.name,
                  status: controller.status,
                  isFavorite: stockDetailsController.isSymbolInWishlist(
                    controller.symbol,
                  ),
                  isFavoriteLoading:
                      stockDetailsController.isSymbolActionInProgress(
                    controller.symbol,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnalysisInfoCard(
                        title: 'Note',
                        value: controller.note,
                        iconColor: const Color(0xFFB54708),
                        iconBackgroundColor: const Color(0xFFFFF2E0),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xff0A0A8F),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withValues(alpha: 0.05),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            AnalysisMetaRow(
                              label: 'Analysis ID',
                              value: '${analysis.id}',
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Colors.white24),
                            const SizedBox(height: 12),
                            AnalysisMetaRow(
                              label: 'Symbol',
                              value: controller.symbol,
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Colors.white24),
                            const SizedBox(height: 12),
                            AnalysisMetaRow(
                              label: 'Status',
                              value: controller.status,
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Colors.white24),
                            const SizedBox(height: 12),
                            AnalysisMetaRow(
                              label: 'Created At',
                              value: controller.createdAt,
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Colors.white24),
                            const SizedBox(height: 12),
                            AnalysisMetaRow(
                              label: 'Updated At',
                              value: controller.updatedAt,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
