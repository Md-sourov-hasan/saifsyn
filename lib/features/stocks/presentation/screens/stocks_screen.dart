import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/notifications/controllers/notification_controller.dart';
import 'package:saifsyn/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:saifsyn/features/stocks/controllers/stocks_controller.dart';
import 'package:saifsyn/features/stocks/data/model/zoya_stocks_models.dart';
import 'package:saifsyn/features/stocks/presentation/widgets/highlighted_stock_card.dart';
import 'package:saifsyn/features/stocks/presentation/widgets/stock_entity_card.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StocksController());
    final notificationController = Get.isRegistered<NotificationController>()
        ? Get.find<NotificationController>()
        : Get.put(NotificationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(controller, notificationController),
            _buildSelectedStockSection(controller),
            _buildSummaryRow(controller),
            _buildSectionTabs(controller),
            Expanded(
              child: Obx(() {
                if (controller.isLoading && !controller.hasAnyData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshDashboard,
                  child: _buildSectionBody(controller),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    StocksController controller,
    NotificationController notificationController,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 18.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2B8E), Color(0xFF173EAF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sharia Stock Explorer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await notificationController.fetchNotifications(
                          showLoader: false,
                        );
                        Get.to(() => const NotificationsScreen());
                      },
                      icon: Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                    if (notificationController.unreadCount > 0)
                      Positioned(
                        right: 6.w,
                        top: 6.h,
                        child: Container(
                          constraints: BoxConstraints(minWidth: 16.w),
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 16.h,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFB2C36),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${notificationController.unreadCount}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
               
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'Specific stock + US ratings + compliant stocks + ETF reports',
              style: TextStyle(
                color: const Color(0xFFD4DEFF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.search_rounded,
                    color: const Color(0xFFE3EBFF),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: controller.symbolTextController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => controller.searchStockBySymbol(),
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search symbol (e.g. AMD)',
                        hintStyle: TextStyle(
                          color: const Color(0xFFC8D6FF),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 26.h,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    height: 38.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: const Color(0xFF00D7A8),
                        foregroundColor: const Color(0xFF052B22),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: controller.isCheckingSymbol
                          ? null
                          : controller.searchStockBySymbol,
                      child: controller.isCheckingSymbol
                          ? SizedBox(
                              width: 16.w,
                              height: 16.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF052B22),
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up_rounded,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Check',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSelectedStockSection(StocksController controller) {
    return Obx(() {
      final selectedStock = controller.selectedStock;
      if (selectedStock == null) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
        child: _buildHighlightedStockCard(selectedStock),
      );
    });
  }

  Widget _buildHighlightedStockCard(ZoyaStockReport stock) {
    return HighlightedStockCard(
      symbol: stock.symbol,
      companyName: stock.name,
      status: stock.status,
    );
  }

  Widget _buildSummaryRow(StocksController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 6.h),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: _summaryCard(
                title: 'US Ratings',
                value: '${controller.ratingsCount}',
                subtitle: '${controller.compliantRatingsCount} compliant',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _summaryCard(
                title: 'Compliant',
                value: '${controller.compliantStocksCount}',
                subtitle: 'US market',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _summaryCard(
                title: 'ETF Reports',
                value: '${controller.etfCount}',
                subtitle: '${controller.compliantEtfCount} compliant',
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF5D687B),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF0E1B2E),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            subtitle,
            style: TextStyle(
              color: const Color(0xFF7A8598),
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTabs(StocksController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 8.h),
      child: Obx(() {
        return Row(
          children: [
            Expanded(
              child: _sectionButton(
                label: 'US Ratings',
                isSelected: controller.activeSection == StocksSection.ratings,
                onTap: () => controller.setActiveSection(StocksSection.ratings),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _sectionButton(
                label: 'Compliant',
                isSelected:
                    controller.activeSection == StocksSection.compliantStocks,
                onTap: () =>
                    controller.setActiveSection(StocksSection.compliantStocks),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _sectionButton(
                label: 'ETF Reports',
                isSelected:
                    controller.activeSection == StocksSection.etfReports,
                onTap: () =>
                    controller.setActiveSection(StocksSection.etfReports),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _sectionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0A2B8E) : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF0A2B8E) : const Color(0xFFD8DFEA),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF334155),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionBody(StocksController controller) {
    return Obx(() {
      if (controller.activeSection == StocksSection.ratings) {
        return _ratingsList(
          controller: controller,
          items: controller.ratings,
        );
      }

      if (controller.activeSection == StocksSection.compliantStocks) {
        return _compliantStocksList(
          controller: controller,
          items: controller.compliantStocks,
        );
      }

      return _etfReportsList(
        controller: controller,
        items: controller.etfReports,
      );
    });
  }

  Widget _ratingsList({
    required StocksController controller,
    required List<ZoyaRatingItem> items,
  }) {
    if (items.isEmpty) {
      return _emptyState(message: 'No rating records found.');
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, index) {
        final item = items[index];
        return StockEntityCard(
          symbol: item.symbol,
          title: item.name,
          subtitle: item.exchange,
          status: item.status,
        );
      },
    );
  }

  Widget _compliantStocksList({
    required StocksController controller,
    required List<ZoyaCompliantStockItem> items,
  }) {
    if (items.isEmpty) {
      return _emptyState(message: 'No compliant stock records found.');
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, index) {
        final item = items[index];
        return StockEntityCard(
          symbol: item.symbol,
          title: item.name,
          subtitle: '${item.exchange} • Report ${_formatDate(item.reportDate)}',
          status: 'COMPLIANT',
        );
      },
    );
  }

  Widget _etfReportsList({
    required StocksController controller,
    required List<ZoyaEtfReportItem> items,
  }) {
    if (items.isEmpty) {
      return _emptyState(message: 'No ETF report records found.');
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, index) {
        final item = items[index];
        return StockEntityCard(
          symbol: item.symbol,
          title: item.name,
          subtitle:
              'Report ${_formatDate(item.reportDate)} • Holdings ${_formatDate(item.holdingsAsOfDate)}',
          status: item.status,
        );
      },
    );
  }

  Widget _emptyState({required String message}) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 90.h),
        Center(
          child: Text(
            message,
            style: TextStyle(
              color: const Color(0xFF677489),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '--';
    }
    return DateFormat('dd MMM yyyy').format(date.toLocal());
  }
}
