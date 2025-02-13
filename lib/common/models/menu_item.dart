class MenuItem {
  final int id;
  final String restaurantId;
  final String name;
  final double price;
  final String? description;
  final String? arContentUrl;
  final bool? isSignature;
  final int? trendingScore;
  final String? photo;

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    this.description,
    this.arContentUrl,
    this.isSignature,
    this.trendingScore,
    this.photo,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as int,
      restaurantId: json['restaurantId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String?,
      arContentUrl: json['arContentUrl'] as String?,
      isSignature: json['isSignature'] as bool?,
      trendingScore: json['trendingScore'] as int?,
      photo: json['photo'] as String?,
    );
  }
}
