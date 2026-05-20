class AuthTermsResponseModel {
  final bool success;
  final AuthTermsData? data;

  AuthTermsResponseModel({
    required this.success,
    this.data,
  });

  factory AuthTermsResponseModel.fromJson(Map<String, dynamic> json) {
    final successValue = json['success'];
    return AuthTermsResponseModel(
      success: successValue is bool
          ? successValue
          : successValue?.toString().toLowerCase() == 'true',
      data: json['data'] is Map<String, dynamic>
          ? AuthTermsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AuthTermsData {
  final int id;
  final AuthTermsContent content;
  final bool isActive;
  final String? createdAt;
  final String? updatedAt;

  AuthTermsData({
    required this.id,
    required this.content,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthTermsData.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return AuthTermsData(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      content: json['content'] is Map<String, dynamic>
          ? AuthTermsContent.fromJson(json['content'] as Map<String, dynamic>)
          : AuthTermsContent(en: '', bn: ''),
      isActive:
          json['is_active'] == true || json['is_active']?.toString() == '1',
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}

class AuthTermsContent {
  final String bn;
  final String en;

  AuthTermsContent({
    required this.bn,
    required this.en,
  });

  factory AuthTermsContent.fromJson(Map<String, dynamic> json) {
    return AuthTermsContent(
      bn: json['bn']?.toString() ?? '',
      en: json['en']?.toString() ?? '',
    );
  }
}
