class ZoyaStockResponse {
  final ZoyaStockReport? report;

  ZoyaStockResponse({required this.report});

  factory ZoyaStockResponse.fromJson(Map<String, dynamic> json) {
    final data = _asMap(json['data']);
    final basicCompliance = _asMap(data['basicCompliance']);
    final reportJson = _asMap(basicCompliance['report']);

    return ZoyaStockResponse(
      report: reportJson.isEmpty ? null : ZoyaStockReport.fromJson(reportJson),
    );
  }
}

class ZoyaStockReport {
  final String symbol;
  final String name;
  final String exchange;
  final String status;

  ZoyaStockReport({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.status,
  });

  factory ZoyaStockReport.fromJson(Map<String, dynamic> json) {
    return ZoyaStockReport(
      symbol: _toString(json['symbol']),
      name: _toString(json['name']),
      exchange: _toString(json['exchange']),
      status: _toString(json['status']),
    );
  }
}

class ZoyaRatingsResponse {
  final List<ZoyaRatingItem> items;
  final String? nextToken;

  ZoyaRatingsResponse({
    required this.items,
    required this.nextToken,
  });

  factory ZoyaRatingsResponse.fromJson(Map<String, dynamic> json) {
    final data = _asMap(json['data']);
    final basicCompliance = _asMap(data['basicCompliance']);
    final reports = _asMap(basicCompliance['reports']);
    final items =
        _asListOfMap(reports['items']).map(ZoyaRatingItem.fromJson).toList();

    return ZoyaRatingsResponse(
      items: items,
      nextToken: _toNullableString(reports['nextToken']),
    );
  }
}

class ZoyaRatingItem {
  final String symbol;
  final String name;
  final String exchange;
  final String status;

  ZoyaRatingItem({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.status,
  });

  factory ZoyaRatingItem.fromJson(Map<String, dynamic> json) {
    return ZoyaRatingItem(
      symbol: _toString(json['symbol']),
      name: _toString(json['name']),
      exchange: _toString(json['exchange']),
      status: _toString(json['status']),
    );
  }
}

class ZoyaCompliantStocksResponse {
  final List<ZoyaCompliantStockItem> items;
  final String? nextToken;

  ZoyaCompliantStocksResponse({
    required this.items,
    required this.nextToken,
  });

  factory ZoyaCompliantStocksResponse.fromJson(Map<String, dynamic> json) {
    final data = _asMap(json['data']);
    final basicCompliance = _asMap(data['basicCompliance']);
    final reports = _asMap(basicCompliance['reports']);
    final items = _asListOfMap(reports['items'])
        .map(ZoyaCompliantStockItem.fromJson)
        .toList();

    return ZoyaCompliantStocksResponse(
      items: items,
      nextToken: _toNullableString(reports['nextToken']),
    );
  }
}

class ZoyaCompliantStockItem {
  final String symbol;
  final String name;
  final String exchange;
  final DateTime? reportDate;

  ZoyaCompliantStockItem({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.reportDate,
  });

  factory ZoyaCompliantStockItem.fromJson(Map<String, dynamic> json) {
    return ZoyaCompliantStockItem(
      symbol: _toString(json['symbol']),
      name: _toString(json['name']),
      exchange: _toString(json['exchange']),
      reportDate: _toDateTime(json['reportDate']),
    );
  }
}

class ZoyaEtfReportsResponse {
  final List<ZoyaEtfReportItem> items;
  final String? nextToken;

  ZoyaEtfReportsResponse({
    required this.items,
    required this.nextToken,
  });

  factory ZoyaEtfReportsResponse.fromJson(Map<String, dynamic> json) {
    final data = _asMap(json['data']);
    final basicCompliance = _asMap(data['basicCompliance']);
    final funds = _asMap(basicCompliance['funds']);
    final items =
        _asListOfMap(funds['items']).map(ZoyaEtfReportItem.fromJson).toList();

    return ZoyaEtfReportsResponse(
      items: items,
      nextToken: _toNullableString(funds['nextToken']),
    );
  }
}

class ZoyaEtfReportItem {
  final String symbol;
  final String name;
  final String status;
  final DateTime? reportDate;
  final DateTime? holdingsAsOfDate;

  ZoyaEtfReportItem({
    required this.symbol,
    required this.name,
    required this.status,
    required this.reportDate,
    required this.holdingsAsOfDate,
  });

  factory ZoyaEtfReportItem.fromJson(Map<String, dynamic> json) {
    return ZoyaEtfReportItem(
      symbol: _toString(json['symbol']),
      name: _toString(json['name']),
      status: _toString(json['status']),
      reportDate: _toDateTime(json['reportDate']),
      holdingsAsOfDate: _toDateTime(json['holdingsAsOfDate']),
    );
  }
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return value.map((key, mapValue) => MapEntry('$key', mapValue));
  }
  return <String, dynamic>{};
}

List<Map<String, dynamic>> _asListOfMap(dynamic value) {
  if (value is List) {
    return value.map(_asMap).where((item) => item.isNotEmpty).toList();
  }
  return <Map<String, dynamic>>[];
}

String _toString(dynamic value) {
  return value?.toString().trim() ?? '';
}

String? _toNullableString(dynamic value) {
  final parsed = value?.toString().trim();
  if (parsed == null || parsed.isEmpty) {
    return null;
  }
  return parsed;
}

DateTime? _toDateTime(dynamic value) {
  if (value == null) {
    return null;
  }
  return DateTime.tryParse(value.toString());
}
