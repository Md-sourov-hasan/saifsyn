class AboutResponseModel {
  final bool success;
  final AboutData? data;

  AboutResponseModel({
    required this.success,
    this.data,
  });

  factory AboutResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return AboutResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      data: json['data'] is Map<String, dynamic>
          ? AboutData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AboutData {
  final int id;
  final String? description;
  final String? ourMission;
  final String? ourVision;
  final String? video;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  AboutData({
    required this.id,
    this.description,
    this.ourMission,
    this.ourVision,
    this.video,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AboutData.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return AboutData(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      description: json['description']?.toString(),
      ourMission: json['our_mission']?.toString(),
      ourVision: json['our_vision']?.toString(),
      video: json['video']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
    );
  }
}
