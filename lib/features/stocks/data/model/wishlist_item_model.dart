class WishlistItem {
  final int id;
  final int userId;
  final String stockSymbol;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  WishlistItem({
    required this.id,
    required this.userId,
    required this.stockSymbol,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String get normalizedSymbol => stockSymbol.trim().toUpperCase();

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final userIdValue = json['user_id'];
    return WishlistItem(
      id: idValue is int ? idValue : int.tryParse(idValue.toString()) ?? 0,
      userId: userIdValue is int
          ? userIdValue
          : int.tryParse(userIdValue.toString()) ?? 0,
      stockSymbol: json['stock_symbol']?.toString() ?? '',
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
    );
  }
}
