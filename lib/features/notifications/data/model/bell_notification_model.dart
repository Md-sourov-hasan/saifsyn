class BellNotificationsResponseModel {
  final bool success;
  final int count;
  final List<BellNotificationItemModel> data;

  BellNotificationsResponseModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory BellNotificationsResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    final countValue = json['count'];
    final rawData = json['data'];

    return BellNotificationsResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      count: countValue is int
          ? countValue
          : int.tryParse(countValue.toString()) ?? 0,
      data: rawData is List
          ? rawData
              .whereType<Map<String, dynamic>>()
              .map(BellNotificationItemModel.fromJson)
              .toList()
          : <BellNotificationItemModel>[],
    );
  }
}

class BellNotificationItemModel {
  final int id;
  final int userId;
  final int analysisId;
  final int isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BellNotificationAnalysisModel? analysis;

  const BellNotificationItemModel({
    required this.id,
    required this.userId,
    required this.analysisId,
    required this.isRead,
    this.createdAt,
    this.updatedAt,
    this.analysis,
  });

  bool get isUnread => isRead == 0;

  BellNotificationItemModel copyWith({
    int? isRead,
  }) {
    return BellNotificationItemModel(
      id: id,
      userId: userId,
      analysisId: analysisId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
      updatedAt: updatedAt,
      analysis: analysis,
    );
  }

  factory BellNotificationItemModel.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final userIdValue = json['user_id'];
    final analysisIdValue = json['analysis_id'];
    final isReadValue = json['is_read'];

    return BellNotificationItemModel(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      userId: userIdValue is int
          ? userIdValue
          : int.tryParse(userIdValue.toString()) ?? 0,
      analysisId: analysisIdValue is int
          ? analysisIdValue
          : int.tryParse(analysisIdValue.toString()) ?? 0,
      isRead: isReadValue is int
          ? isReadValue
          : int.tryParse(isReadValue.toString()) ?? 0,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? ''),
      analysis: json['analysis'] is Map<String, dynamic>
          ? BellNotificationAnalysisModel.fromJson(
              json['analysis'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class BellNotificationAnalysisModel {
  final int id;
  final String symbol;
  final String name;
  final String note;

  const BellNotificationAnalysisModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.note,
  });

  factory BellNotificationAnalysisModel.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];

    return BellNotificationAnalysisModel(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      symbol: json['symbol']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
    );
  }
}
