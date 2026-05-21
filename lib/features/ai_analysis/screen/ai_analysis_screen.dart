import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/features/ai_analysis/controller/ai_analysis_controller.dart';
import 'package:saifsyn/features/ai_analysis/widgets/ai_analysis_screen_widgets.dart';

class AiAnalysisScreen extends StatelessWidget {
  const AiAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalysisController());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Obx(() {
          final width = MediaQuery.sizeOf(context).width;
          final showSidebar = width >= 1100;
          final isMobile = width < 700;

          return Column(
            children: [
              Obx(() => ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: controller.floatingHeightFactor.value,
                      child: AiAnalysisTopHero(
                        controller: controller,
                        isMobile: isMobile,
                        showHistoryButton: !showSidebar,
                        onHistoryTap: () => _showHistorySheet(context, controller),
                      ),
                    ),
                  )),
              Expanded(
                child: controller.isBootstrapping && !controller.hasResult
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: controller.refreshCurrent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                controller: controller.contentScrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(
                                  isMobile ? 12.w : 16.w,
                                  isMobile ? 12.h : 18.h,
                                  showSidebar ? 8.w : (isMobile ? 12.w : 16.w),
                                  isMobile ? 18.h : 28.h,
                                ),
                                child: AiAnalysisMainContent(
                                  controller: controller,
                                  isMobile: isMobile,
                                ),
                              ),
                            ),
                            if (showSidebar)
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  8.w,
                                  18.h,
                                  16.w,
                                  28.h,
                                ),
                                child: SizedBox(
                                  width: 320.w,
                                  child: AiAnalysisHistoryPanel(
                                    controller: controller,
                                  ),
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

void _showHistorySheet(
  BuildContext context,
  AnalysisController controller,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return FractionallySizedBox(
        heightFactor: 0.82,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFFF6F7FB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
            child: AiAnalysisHistoryPanel(
              controller: controller,
              onItemTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      );
    },
  );
}
