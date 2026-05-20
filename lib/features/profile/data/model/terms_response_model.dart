class TermsResponseModel {
  final bool success;
  final TermsData? data;

  TermsResponseModel({
    required this.success,
    this.data,
  });

  factory TermsResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return TermsResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      data: json['data'] is Map<String, dynamic>
          ? TermsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class TermsData {
  final int id;
  final TermsContent content;
  final bool isActive;
  final String? createdAt;
  final String? updatedAt;

  TermsData({
    required this.id,
    required this.content,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory TermsData.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return TermsData(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      content: json['content'] is Map<String, dynamic>
          ? TermsContent.fromJson(json['content'] as Map<String, dynamic>)
          : TermsContent(en: '', bn: ''),
      isActive: json['is_active'] == true || json['is_active']?.toString() == '1',
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}

class TermsContent {
  final String bn;
  final String en;

  TermsContent({
    required this.bn,
    required this.en,
  });

  factory TermsContent.fromJson(Map<String, dynamic> json) {
    return TermsContent(
      bn: json['bn']?.toString() ?? '',
      en: json['en']?.toString() ?? '',
    );
  }
}
