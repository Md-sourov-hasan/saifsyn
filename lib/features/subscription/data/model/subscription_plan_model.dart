class SubscriptionPlanModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final List<String> features;
  final String durationType;
  final int durationValue;
  final bool isPopular;
  final bool status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  SubscriptionPlanModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.features,
    required this.durationType,
    required this.durationValue,
    required this.isPopular,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final priceValue = json['price'];
    final durationValue = json['duration_value'];

    return SubscriptionPlanModel(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: priceValue is num
          ? priceValue.toDouble()
          : double.tryParse(priceValue.toString()) ?? 0,
      features: (json['features'] is List)
          ? (json['features'] as List).map((e) => e.toString()).toList()
          : <String>[],
      durationType: json['duration_type']?.toString() ?? '',
      durationValue: durationValue is int
          ? durationValue
          : int.tryParse(durationValue.toString()) ?? 0,
      isPopular: json['is_popular'] == true,
      status: json['status'] == true,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
    );
  }
}
