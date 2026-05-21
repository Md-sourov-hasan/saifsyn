import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/ai_analysis/controller/ai_analysis_controller.dart';
import 'package:saifsyn/features/ai_analysis/data/model/ai_company_analysis_models.dart';
import 'package:saifsyn/core/utils/constants/colors.dart';

class AiAnalysisTopHero extends StatelessWidget {
  const AiAnalysisTopHero({
    super.key,
    required this.controller,
    required this.isMobile,
    required this.showHistoryButton,
    required this.onHistoryTap,
  });

  final AnalysisController controller;
  final bool isMobile;
  final bool showHistoryButton;
  final VoidCallback onHistoryTap;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 760;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, isMobile ? 14.h : 18.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFF7F3FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8EDFF),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Icon(
                        Icons.insights_rounded,
                        color: const Color(0xFF4C3FD7),
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Company Analysis',
                            style: TextStyle(
                              fontSize: isMobile ? 18.sp : 21.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Search a company and review its latest Shariah analysis.',
                            maxLines: isMobile ? 2 : 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: isMobile ? 11.5.sp : 12.5.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (showHistoryButton)
                IconButton(
                  onPressed: onHistoryTap,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.surfaceLight),
                  ),
                  icon: const Icon(Icons.history_rounded),
                  tooltip: 'History',
                ),
            ],
          ),
          SizedBox(height: isMobile ? 14.h : 18.h),
          Flex(
            direction: isCompact ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isCompact
                  ? _SearchField(controller: controller)
                  : Expanded(
                      flex: 5,
                      child: _SearchField(controller: controller),
                    ),
              SizedBox(
                  width: isCompact ? 0 : 12.w, height: isCompact ? 12.h : 0),
              _LanguageToggle(controller: controller),
              SizedBox(
                  width: isCompact ? 0 : 12.w, height: isCompact ? 12.h : 0),
              SizedBox(
                width: isCompact ? double.infinity : 140.w,
                height: isMobile ? 50.h : 52.h,
                child: Obx(() => ElevatedButton(
                  onPressed: controller.isSearching ? null : controller.analyze,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: controller.isSearching
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                            strokeCap: StrokeCap.round,
                          ),
                        )
                      : Text(
                          'Analysis',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                )),
              ),
            ],
          ),
          if (isMobile) ...[
            SizedBox(height: 12.h),
            _MobileTopActions(
              controller: controller,
              onHistoryTap: onHistoryTap,
            ),
          ],
        ],
      ),
    );
  }
}

class _MobileTopActions extends StatelessWidget {
  const _MobileTopActions({
    required this.controller,
    required this.onHistoryTap,
  });

  final AnalysisController controller;
  final VoidCallback onHistoryTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.surfaceLight),
            ),
            child: Obx(
              () => Row(
                children: [
                  const Icon(
                    Icons.language_rounded,
                    size: 18,
                    color: AppColors.accent,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      controller.languageLabel,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${controller.history.length} items',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        InkWell(
          onTap: onHistoryTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.history_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                SizedBox(width: 8.w),
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
  });

  final AnalysisController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller.searchController,
      builder: (context, value, _) {
        return TextField(
          controller: controller.searchController,
          onChanged: (_) => controller.clearError(),
          onSubmitted: (_) => controller.analyze(),
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search company name',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: value.text.trim().isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      controller.searchController.clear();
                      controller.clearError();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.surfaceLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.surfaceLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide:
                  const BorderSide(color: AppColors.accent, width: 1.4),
            ),
          ),
        );
      },
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle({
    required this.controller,
  });

  final AnalysisController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 52.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LanguageChip(
              label: 'English',
              selected: controller.language == AnalysisLanguage.english,
              onTap: () => controller.updateLanguage(AnalysisLanguage.english),
            ),
            SizedBox(width: 4.w),
            _LanguageChip(
              label: 'Arabic',
              selected: controller.language == AnalysisLanguage.arabic,
              onTap: () => controller.updateLanguage(AnalysisLanguage.arabic),
            ),
          ],
        ),
      );
    });
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class AiAnalysisMainContent extends StatelessWidget {
  const AiAnalysisMainContent({
    super.key,
    required this.controller,
    required this.isMobile,
  });

  final AnalysisController controller;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final result = controller.selectedResult;

    if (controller.errorMessage.isNotEmpty && result == null) {
      return _EmptyState(
        title: 'Could not load analysis',
        message: controller.errorMessage,
        actionLabel: 'Retry',
        onAction: controller.bootstrap,
      );
    }

    if (result == null) {
      return _EmptyState(
        title: 'Start with a company search',
        message:
            'Search for a stock like Adobe, Apple, or AMD to view the AI analysis report.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.errorMessage.isNotEmpty) ...[
          _InlineError(message: controller.errorMessage),
          SizedBox(height: 14.h),
        ],
        _ResultHeader(
          result: result,
          languageLabel: controller.languageLabel,
          isMobile: isMobile,
        ),
        SizedBox(height: 16.h),
        if (result.stockSnapshot != null) ...[
          _SnapshotCard(
            snapshot: result.stockSnapshot!,
            status: result.shariahStatus,
            isMobile: isMobile,
          ),
          SizedBox(height: 16.h),
          _ChartCard(
            snapshot: result.stockSnapshot!,
            isMobile: isMobile,
            controller: controller,
          ),
          SizedBox(height: 16.h),
        ],
        ...result.sections.map(
          (section) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: _SectionCard(section: section, isMobile: isMobile),
          ),
        ),
      ],
    );
  }
}

class _ResultHeader extends StatelessWidget {
  const _ResultHeader({
    required this.result,
    required this.languageLabel,
    required this.isMobile,
  });

  final CompanyAnalysisResult result;
  final String languageLabel;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16.w : 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.accent.withValues(alpha: 0.1), const Color(0xFFE0EAFF)],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          _tickerText(result),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        result.companyName,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  '${result.ticker.isEmpty ? 'N/A' : result.ticker} • ${result.stockSnapshot?.exchange.isNotEmpty == true ? result.stockSnapshot!.exchange : 'Market unavailable'}',
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 14.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    _Badge(
                      label: result.shariahStatus.toUpperCase(),
                      color: _statusColor(result.shariahStatus),
                      soft: true,
                    ),
                    _MetaPill(label: languageLabel),
                    if (result.shariahStatusSource.isNotEmpty)
                      _MetaPill(label: 'Source: ${result.shariahStatusSource}'),
                  ],
                ),
              ],
            )
          : Wrap(
              runSpacing: 16.h,
              spacing: 16.w,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent.withValues(alpha: 0.1), const Color(0xFFE0EAFF)],
                    ),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Center(
                    child: Text(
                      _tickerText(result),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 420.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.companyName,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '${result.ticker.isEmpty ? 'N/A' : result.ticker} • ${result.stockSnapshot?.exchange.isNotEmpty == true ? result.stockSnapshot!.exchange : 'Market unavailable'} • $languageLabel',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                _Badge(
                  label: result.shariahStatus.toUpperCase(),
                  color: _statusColor(result.shariahStatus),
                  soft: true,
                ),
                if (result.shariahStatusSource.isNotEmpty)
                  _MetaPill(label: 'Source: ${result.shariahStatusSource}'),
              ],
            ),
    );
  }
}

class _SnapshotCard extends StatelessWidget {
  const _SnapshotCard({
    required this.snapshot,
    required this.status,
    required this.isMobile,
  });

  final StockSnapshot snapshot;
  final String status;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final change = snapshot.percentChange ?? 0;
    final positive = change >= 0;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16.w : 20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF5F3FF), Color(0xFFEEF4FF)],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFD9D6FE)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _MetricBlock(
                        title: 'Current Price',
                        value: _money(snapshot.currentPrice, snapshot.currency),
                        subtitle: '${snapshot.symbol} • ${snapshot.exchange}',
                        compact: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _MetricBlock(
                        title: 'Change',
                        value:
                            '${positive ? '+' : ''}${_fixed(snapshot.percentChange)}%',
                        subtitle:
                            '${positive ? '+' : ''}${_money(snapshot.absoluteChange, snapshot.currency)} absolute',
                        valueColor: positive
                            ? const Color(0xFF16A34A)
                            : const Color(0xFFDC2626),
                        compact: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 108.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _MobileMetricTile(
                        title: 'Day Range',
                        value:
                            '${_money(snapshot.dayLow, snapshot.currency)} - ${_money(snapshot.dayHigh, snapshot.currency)}',
                      ),
                      _MobileMetricTile(
                        title: '52W Range',
                        value:
                            '${_money(snapshot.yearLow, snapshot.currency)} - ${_money(snapshot.yearHigh, snapshot.currency)}',
                      ),
                      _MobileMetricTile(
                        title: 'Last Updated',
                        value: _dateTime(snapshot.lastUpdatedUtc),
                      ),
                      _MobileMetricTile(
                        title: 'Status',
                        value: status.toUpperCase(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Wrap(
              spacing: 20.w,
              runSpacing: 18.h,
              alignment: WrapAlignment.spaceBetween,
              children: [
                _MetricBlock(
                  title: 'Current Price',
                  value: _money(snapshot.currentPrice, snapshot.currency),
                  subtitle: '${snapshot.symbol} • ${snapshot.exchange}',
                ),
                _MetricBlock(
                  title: 'Change',
                  value:
                      '${positive ? '+' : ''}${_fixed(snapshot.percentChange)}%',
                  subtitle:
                      '${positive ? '+' : ''}${_money(snapshot.absoluteChange, snapshot.currency)} absolute',
                  valueColor: positive
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFDC2626),
                ),
                _MetricBlock(
                  title: 'Day Range',
                  value:
                      '${_money(snapshot.dayLow, snapshot.currency)} - ${_money(snapshot.dayHigh, snapshot.currency)}',
                  subtitle:
                      '52W: ${_money(snapshot.yearLow, snapshot.currency)} - ${_money(snapshot.yearHigh, snapshot.currency)}',
                ),
                _MetricBlock(
                  title: 'Last Updated',
                  value: _dateTime(snapshot.lastUpdatedUtc),
                  subtitle: 'Status: ${status.toUpperCase()}',
                ),
              ],
            ),
    );
  }
}

class _MetricBlock extends StatelessWidget {
  const _MetricBlock({
    required this.title,
    required this.value,
    required this.subtitle,
    this.valueColor,
    this.compact = false,
  });

  final String title;
  final String value;
  final String subtitle;
  final Color? valueColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: compact ? double.infinity : 220.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: compact ? 22.sp : 26.sp,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.snapshot,
    required this.isMobile,
    required this.controller,
  });

  final StockSnapshot snapshot;
  final bool isMobile;
  final AnalysisController controller;

  List<ChartPoint> _pointsForDuration(ChartDuration duration) {
    switch (duration) {
      case ChartDuration.days30:
        return snapshot.chart30d;
      case ChartDuration.months3:
        return snapshot.chart3m;
      case ChartDuration.months6:
        return snapshot.chart6m;
      case ChartDuration.year1:
        return snapshot.chart1y;
    }
  }

  String _labelForDuration(ChartDuration duration) {
    switch (duration) {
      case ChartDuration.days30:
        return '30 Days';
      case ChartDuration.months3:
        return '3 Months';
      case ChartDuration.months6:
        return '6 Months';
      case ChartDuration.year1:
        return '1 Year';
    }
  }

  String _dateFormatForDuration(ChartDuration duration) {
    switch (duration) {
      case ChartDuration.days30:
        return 'd MMM';
      case ChartDuration.months3:
        return 'd MMM';
      case ChartDuration.months6:
        return 'd MMM';
      case ChartDuration.year1:
        return 'd MMM';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final duration = controller.selectedChartDuration.value;
      final points = _pointsForDuration(duration);
      final labels = _labelIndexes(points.length,
          twoLabelsOnly: duration == ChartDuration.days30);
      final minY = points.isEmpty
          ? 0.0
          : points.map((e) => e.close).reduce(math.min);
      final maxY = points.isEmpty
          ? 1.0
          : points.map((e) => e.close).reduce(math.max);

      return Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 16.w : 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.surfaceLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.w : 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Chart',
                          style: TextStyle(
                            fontSize: isMobile ? 18.sp : 22.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1D2939),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Closing price trend — ${_labelForDuration(duration)}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            // Period toggle bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.w : 20.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ChartDuration.values.map((d) {
                    final isSelected = duration == d;
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () => controller.changeChartDuration(d),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 14.w : 16.w,
                            vertical: isMobile ? 7.h : 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent
                                : const Color(0xFFF4F4F6),
                            borderRadius: BorderRadius.circular(50.r),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.accent
                                          .withValues(alpha: 0.28),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            _labelForDuration(d),
                            style: TextStyle(
                              fontSize: isMobile ? 11.sp : 12.sp,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.only(
                left: isMobile ? 6.w : 8.w,
                right: isMobile ? 16.w : 20.w,
              ),
              child: SizedBox(
                height: isMobile ? 240.h : 300.h,
                child: points.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bar_chart_rounded,
                              size: 40.sp,
                              color: AppColors.surfaceLight,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'No chart data for this period',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : LineChart(
                        LineChartData(
                          minY: minY,
                          maxY: maxY,
                          minX: 0,
                          maxX: points.isEmpty
                              ? 0
                              : (points.length - 1).toDouble(),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: (maxY - minY) / 4,
                            getDrawingHorizontalLine: (_) => const FlLine(
                              color: AppColors.surfaceLight,
                              strokeWidth: 1,
                            ),
                          ),
                          titlesData: FlTitlesData(
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: isMobile ? 42.w : 52.w,
                                interval: (maxY - minY) / 4,
                                getTitlesWidget: (value, meta) {
                                  final bool isBoundary = value == meta.min || value == meta.max;
                                  final double range = meta.max - meta.min;
                                  
                                  if (!isBoundary) {
                                    // Hide interval if it's too close to the min or max boundary
                                    if ((value - meta.min).abs() < range * 0.15 || 
                                        (meta.max - value).abs() < range * 0.15) {
                                      return const SizedBox.shrink();
                                    }
                                  }

                                  return Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: Text(
                                      _axisMoney(value, snapshot.currency),
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: isMobile ? 10.sp : 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: math
                                    .max(1, (points.length / 8).ceil())
                                    .toDouble(),
                                reservedSize: isMobile ? 26.h : 30.h,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (!labels.contains(index) ||
                                      index < 0 ||
                                      index >= points.length) {
                                    return const SizedBox.shrink();
                                  }
                                  final date = points[index].timestampUtc;
                                  final isFirst = index == 0;
                                  final isLast = index >= points.length - 1;

                                  return SizedBox(
                                    width: 0,
                                    child: OverflowBox(
                                      minWidth: 0,
                                      maxWidth: double.infinity,
                                      alignment: isFirst
                                          ? Alignment.centerLeft
                                          : (isLast
                                              ? Alignment.centerRight
                                              : Alignment.center),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: Text(
                                          date == null
                                              ? ''
                                              : DateFormat(
                                                      _dateFormatForDuration(
                                                          duration))
                                                  .format(date),
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: isMobile ? 9.sp : 10.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipColor: (_) => AppColors.textPrimary,
                              getTooltipItems: (spots) {
                                return spots.map((spot) {
                                  final point = points[spot.x.toInt()];
                                  return LineTooltipItem(
                                    '${_money(point.close, snapshot.currency)}\n',
                                    TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: point.timestampUtc == null
                                            ? ''
                                            : DateFormat('dd MMM yyyy')
                                                .format(point.timestampUtc!),
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList();
                              },
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              barWidth: 3.2,
                              color: AppColors.accent,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.accent
                                        .withValues(alpha: 0.18),
                                    AppColors.accent
                                        .withValues(alpha: 0.01),
                                  ],
                                ),
                              ),
                              spots: [
                                for (var i = 0; i < points.length; i++)
                                  FlSpot(i.toDouble(), points[i].close),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.section,
    required this.isMobile,
  });

  final AnalysisSection section;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16.w : 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: TextStyle(
              fontSize: isMobile ? 19.sp : 24.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1D2939),
            ),
          ),
          SizedBox(height: 14.h),
          Divider(color: AppColors.surfaceLight, height: 1.h),
          SizedBox(height: 18.h),
          ..._buildSectionContent(section.content, isMobile),
          if (section.tables.isNotEmpty) SizedBox(height: 8.h),
          ...section.tables.map(
            (table) => Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: _AnalysisTableWidget(table: table),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalysisTableWidget extends StatelessWidget {
  const _AnalysisTableWidget({
    required this.table,
  });

  final AnalysisTable table;

  @override
  Widget build(BuildContext context) {
    if (table.columns.isEmpty || table.rows.isEmpty) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 28.w,
            headingRowColor: WidgetStateProperty.all(
              const Color(0xFFF8FAFC),
            ),
            dataRowMinHeight: 52.h,
            dataRowMaxHeight: 72.h,
            columns: table.columns.map(
              (column) {
                final isFirst = table.columns.indexOf(column) == 0;
                return DataColumn(
                  numeric: !isFirst,
                  label: SizedBox(
                    width: isFirst ? 140.w : 80.w,
                    child: Text(
                      column,
                      textAlign: isFirst ? TextAlign.left : TextAlign.right,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
            rows: table.rows.map((row) {
              return DataRow(
                cells: table.columns.map(
                  (column) {
                    final isFirst = table.columns.indexOf(column) == 0;
                    return DataCell(
                      SizedBox(
                        width: isFirst ? 140.w : 80.w,
                        child: Text(
                          row[column] ?? '',
                          textAlign: isFirst ? TextAlign.left : TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _MobileMetricTile extends StatelessWidget {
  const _MobileMetricTile({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFD9D6FE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF1D2939),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AiAnalysisHistoryPanel extends StatelessWidget {
  const AiAnalysisHistoryPanel({
    super.key,
    required this.controller,
    this.onItemTap,
  });

  final AnalysisController controller;
  final VoidCallback? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 14.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Obx(() => IconButton(
                    onPressed: controller.fetchHistory,
                    icon: controller.isHistoryLoading
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.refresh_rounded),
                  )),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.history.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'Your recent analysis searches will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }

      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: controller.history.length,
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemBuilder: (context, index) {
          final item = controller.history[index];
          final selected = item.id == controller.selectedHistoryId;

          return InkWell(
            borderRadius: BorderRadius.circular(18.r),
            onTap: () async {
              await controller.openHistoryItem(item);
              onItemTap?.call();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFF1EEFF)
                    : const Color(0xFFFCFCFD),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: selected
                      ? const Color(0xFFD9D6FE)
                      : AppColors.surfaceLight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.ticker?.isNotEmpty == true
                              ? item.ticker!
                              : item.companyName,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      _Badge(
                        label: item.shariahStatus.toUpperCase(),
                        color: _statusColor(item.shariahStatus),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.companyName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          _historyDate(item.searchedAt),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        item.language.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    })),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.color,
    this.soft = false,
  });

  final String label;
  final Color color;
  final bool soft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: soft ? color.withValues(alpha: 0.12) : Colors.white,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: color.withValues(alpha: soft ? 0.35 : 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF475467),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFDA29B)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded, color: Color(0xFFB42318)),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF912018),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.auto_graph_rounded,
              size: 32.sp,
              color: AppColors.accent,
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: 18.h),
            ElevatedButton(
              onPressed: onAction,
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

String _tickerText(CompanyAnalysisResult result) {
  final ticker = result.ticker.trim();
  if (ticker.isNotEmpty) return ticker;
  return result.companyName.trim().isEmpty
      ? 'AI'
      : result.companyName.trim().substring(0, 1).toUpperCase();
}

Set<int> _labelIndexes(int length, {bool twoLabelsOnly = false}) {
  if (length <= 1) return {0};

  // For 30 Days: show only first and last date (like 3 Months view)
  if (twoLabelsOnly) {
    return {0, length - 1};
  }

  // Show at most 6 labels; enforce a minimum gap so the last label
  // cannot crowd the one before it.
  const maxLabels = 6;
  final step = math.max(1, (length / maxLabels).ceil());

  final indexes = <int>{};
  for (var i = 0; i < length; i += step) {
    indexes.add(i);
  }

  // Add the last index only if it is far enough from the previous label
  final lastLabel = indexes.isEmpty ? 0 : indexes.last;
  if ((length - 1) - lastLabel >= step ~/ 2) {
    indexes.add(length - 1);
  }

  return indexes;
}

List<Widget> _buildSectionContent(String content, bool isMobile) {
  final lines = content
      .split('\n')
      .map((line) => line.trimRight())
      .where((line) => line.trim().isNotEmpty)
      .toList();

  return lines.map((line) {
    final trimmed = line.trim();

    if (trimmed.startsWith('###')) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Text(
          trimmed.replaceFirst('###', '').trim(),
          style: TextStyle(
            fontSize: isMobile ? 15.5.sp : 17.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      );
    }

    if (trimmed.startsWith('- ')) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 7.h, right: 10.w),
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: Text(
                _cleanupInlineMarkdown(trimmed.substring(2).trim()),
                style: _bodyStyle(isMobile),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        _cleanupInlineMarkdown(trimmed),
        style: _bodyStyle(isMobile),
      ),
    );
  }).toList();
}

TextStyle _bodyStyle(bool isMobile) => TextStyle(
      fontSize: isMobile ? 13.5.sp : 14.5.sp,
      height: isMobile ? 1.6 : 1.7,
      color: const Color(0xFF475467),
      fontWeight: FontWeight.w500,
    );

String _cleanupInlineMarkdown(String value) {
  return value.replaceAll('**', '').replaceAll('  ', ' ');
}

Color _statusColor(String status) {
  switch (status.trim().toLowerCase()) {
    case 'halal':
    case 'compliant':
      return const Color(0xFF16A34A);
    case 'haram':
    case 'non_compliant':
      return const Color(0xFFDC2626);
    default:
      return AppColors.textSecondary;
  }
}

String _money(double? value, String currency) {
  if (value == null) return 'N/A';
  final symbol =
      currency.toUpperCase() == 'USD' ? '\$' : '${currency.toUpperCase()} ';
  return '$symbol${value.toStringAsFixed(2)}';
}

String _axisMoney(double value, String currency) {
  final symbol = currency.toUpperCase() == 'USD' ? '\$' : '';
  return '$symbol${value.toStringAsFixed(0)}';
}

String _fixed(double? value) {
  if (value == null) return '0.00';
  return value.toStringAsFixed(2);
}

String _dateTime(DateTime? dateTime) {
  if (dateTime == null) return 'N/A';
  return DateFormat('M/d/yyyy, h:mm a').format(dateTime.toLocal());
}

String _historyDate(DateTime? dateTime) {
  if (dateTime == null) return 'Unknown date';
  return DateFormat('MMM d, yyyy').format(dateTime.toLocal());
}
