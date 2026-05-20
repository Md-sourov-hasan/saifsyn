class ContactResponseModel {
  final String message;
  final ContactData? data;

  ContactResponseModel({
    required this.message,
    this.data,
  });

  factory ContactResponseModel.fromJson(Map<String, dynamic> json) {
    return ContactResponseModel(
      message: json['message']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? ContactData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ContactData {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String message;
  final String? createdAt;
  final String? updatedAt;

  ContactData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    return ContactData(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }
}
