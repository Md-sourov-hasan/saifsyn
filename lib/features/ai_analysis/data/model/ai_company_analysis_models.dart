class CompanyAnalysisResult {
  final String companyName;
  final String shariahStatus;
  final String shariahStatusSource;
  final String ticker;
  final StockSnapshot? stockSnapshot;
  final List<AnalysisSection> sections;

  CompanyAnalysisResult({
    required this.companyName,
    required this.shariahStatus,
    required this.shariahStatusSource,
    required this.ticker,
    required this.stockSnapshot,
    required this.sections,
  });

  factory CompanyAnalysisResult.fromJson(Map<String, dynamic> json) {
    return CompanyAnalysisResult(
      companyName: json['company_name']?.toString() ?? '',
      shariahStatus: json['shariah_status']?.toString() ?? 'unknown',
      shariahStatusSource: json['shariah_status_source']?.toString() ?? '',
      ticker: json['ticker']?.toString() ?? '',
      stockSnapshot: json['stock_snapshot'] is Map<String, dynamic>
          ? StockSnapshot.fromJson(
              json['stock_snapshot'] as Map<String, dynamic>,
            )
          : null,
      sections: (json['sections'] as List<dynamic>? ?? <dynamic>[])
          .whereType<Map<String, dynamic>>()
          .map(AnalysisSection.fromJson)
          .toList(),
    );
  }
}

class StockSnapshot {
  final String symbol;
  final String exchange;
  final String currency;
  final double? currentPrice;
  final double? previousClose;
  final double? absoluteChange;
  final double? percentChange;
  final double? open;
  final double? dayLow;
  final double? dayHigh;
  final double? yearLow;
  final double? yearHigh;
  final int? volume;
  final double? marketCap;
  final double? epsTtm;
  final double? peRatio;

  /// All historical chart points — used to derive period-filtered views.
  final List<ChartPoint> chartHistory;

  final DateTime? lastUpdatedUtc;

  StockSnapshot({
    required this.symbol,
    required this.exchange,
    required this.currency,
    required this.currentPrice,
    required this.previousClose,
    required this.absoluteChange,
    required this.percentChange,
    required this.open,
    required this.dayLow,
    required this.dayHigh,
    required this.yearLow,
    required this.yearHigh,
    required this.volume,
    required this.marketCap,
    required this.epsTtm,
    required this.peRatio,
    required this.chartHistory,
    required this.lastUpdatedUtc,
  });

  // ── Period-filtered getters (client-side, no extra backend calls) ──────────

  List<ChartPoint> get chart30d => _filterDays(30);
  List<ChartPoint> get chart3m  => _filterDays(90);
  List<ChartPoint> get chart6m  => _filterDays(180);
  List<ChartPoint> get chart1y  => _filterDays(365);

  List<ChartPoint> _filterDays(int days) {
    if (chartHistory.isEmpty) return const [];
    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));
    final filtered = chartHistory
        .where((p) => p.timestampUtc != null && p.timestampUtc!.isAfter(cutoff))
        .toList();
    // If filtering returns nothing (all data is older), return full history
    return filtered.isEmpty ? chartHistory : filtered;
  }

  factory StockSnapshot.fromJson(Map<String, dynamic> json) {
    // Accept either chart_history (preferred) or chart_30d as the source.
    List<ChartPoint> parsePoints(dynamic raw) =>
        (raw as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(ChartPoint.fromJson)
            .toList();

    final history = json['chart_history'] != null
        ? parsePoints(json['chart_history'])
        : parsePoints(json['chart_30d']);

    return StockSnapshot(
      symbol: json['symbol']?.toString() ?? '',
      exchange: json['exchange']?.toString() ?? '',
      currency: json['currency']?.toString() ?? '',
      currentPrice: _toDouble(json['current_price']),
      previousClose: _toDouble(json['previous_close']),
      absoluteChange: _toDouble(json['absolute_change']),
      percentChange: _toDouble(json['percent_change']),
      open: _toDouble(json['open']),
      dayLow: _toDouble(json['day_low']),
      dayHigh: _toDouble(json['day_high']),
      yearLow: _toDouble(json['year_low']),
      yearHigh: _toDouble(json['year_high']),
      volume: _toInt(json['volume']),
      marketCap: _toDouble(json['market_cap']),
      epsTtm: _toDouble(json['eps_ttm']),
      peRatio: _toDouble(json['pe_ratio']),
      chartHistory: history,
      lastUpdatedUtc: DateTime.tryParse(
        json['last_updated_utc']?.toString() ?? '',
      ),
    );
  }
}

class ChartPoint {
  final DateTime? timestampUtc;
  final double close;

  ChartPoint({
    required this.timestampUtc,
    required this.close,
  });

  factory ChartPoint.fromJson(Map<String, dynamic> json) {
    return ChartPoint(
      timestampUtc: DateTime.tryParse(json['timestamp_utc']?.toString() ?? ''),
      close: _toDouble(json['close']) ?? 0,
    );
  }
}

class AnalysisSection {
  final String title;
  final String content;
  final List<AnalysisTable> tables;

  AnalysisSection({
    required this.title,
    required this.content,
    required this.tables,
  });

  factory AnalysisSection.fromJson(Map<String, dynamic> json) {
    return AnalysisSection(
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      tables: (json['tables'] as List<dynamic>? ?? <dynamic>[])
          .whereType<Map<String, dynamic>>()
          .map(AnalysisTable.fromJson)
          .toList(),
    );
  }
}

class AnalysisTable {
  final List<String> columns;
  final List<Map<String, String>> rows;

  AnalysisTable({
    required this.columns,
    required this.rows,
  });

  factory AnalysisTable.fromJson(Map<String, dynamic> json) {
    final columns = (json['columns'] as List<dynamic>? ?? <dynamic>[])
        .map((item) => item.toString())
        .toList();
    final rows = (json['rows'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(
          (row) => row.map(
            (key, value) => MapEntry(key.toString(), value?.toString() ?? ''),
          ),
        )
        .toList();

    return AnalysisTable(columns: columns, rows: rows);
  }
}

class AnalysisHistoryItem {
  final String id;
  final String companyName;
  final String? ticker;
  final String language;
  final String shariahStatus;
  final DateTime? searchedAt;

  AnalysisHistoryItem({
    required this.id,
    required this.companyName,
    required this.ticker,
    required this.language,
    required this.shariahStatus,
    required this.searchedAt,
  });

  factory AnalysisHistoryItem.fromJson(Map<String, dynamic> json) {
    return AnalysisHistoryItem(
      id: json['id']?.toString() ?? '',
      companyName: json['company_name']?.toString() ?? '',
      ticker: json['ticker']?.toString(),
      language: json['language']?.toString() ?? 'english',
      shariahStatus: json['shariah_status']?.toString() ?? 'unknown',
      searchedAt: DateTime.tryParse(json['searched_at']?.toString() ?? ''),
    );
  }
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}
