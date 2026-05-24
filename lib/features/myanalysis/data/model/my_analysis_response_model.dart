class AnalysisResponseModel {
  final bool success;
  final List<AnalysisItemModel> data;
  final AnalysisMetaModel? meta;

  AnalysisResponseModel({
    required this.success,
    required this.data,
    this.meta,
  });

  factory AnalysisResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    final rawData = json['data'];

    return AnalysisResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      data: rawData is List
          ? rawData
              .whereType<Map<String, dynamic>>()
              .map(AnalysisItemModel.fromJson)
              .toList()
          : <AnalysisItemModel>[],
      meta: json['meta'] is Map<String, dynamic>
          ? AnalysisMetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AnalysisItemModel {
  final int id;
  final String symbol;
  final String name;
  final String status;
  final String recommendation;
  final String note;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  AnalysisItemModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.status,
    required this.recommendation,
    required this.note,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AnalysisItemModel.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return AnalysisItemModel(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      symbol: json['symbol']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      recommendation: json['recommendation']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}

class AnalysisMetaModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  AnalysisMetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory AnalysisMetaModel.fromJson(Map<String, dynamic> json) {
    final currentPageValue = json['current_page'];
    final lastPageValue = json['last_page'];
    final perPageValue = json['per_page'];
    final totalValue = json['total'];

    return AnalysisMetaModel(
      currentPage: currentPageValue is int
          ? currentPageValue
          : int.tryParse(currentPageValue.toString()) ?? 0,
      lastPage: lastPageValue is int
          ? lastPageValue
          : int.tryParse(lastPageValue.toString()) ?? 0,
      perPage: perPageValue is int
          ? perPageValue
          : int.tryParse(perPageValue.toString()) ?? 0,
      total: totalValue is int
          ? totalValue
          : int.tryParse(totalValue.toString()) ?? 0,
    );
  }
}
