import 'package:snapfood/common/models/generated_classes.dart';

enum PromotionType { AMOUNT, PERCENTAGE }

class Promotion extends MenuItems {
  const Promotion({
    required super.id,
    required super.restaurantId,
    required super.name,
    required super.price,
    required this.type,
    required this.amount,
    this.maxUses,
    super.description,
    super.arContentUrl,
    super.isSignature,
    super.trendingScore,
    super.photo,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    final menuItem = MenuItems.fromJson(json);
    return Promotion(
      id: menuItem.id,
      restaurantId: menuItem.restaurantId,
      name: menuItem.name,
      price: menuItem.price,
      description: menuItem.description,
      arContentUrl: menuItem.arContentUrl,
      isSignature: menuItem.isSignature,
      trendingScore: menuItem.trendingScore,
      photo: menuItem.photo,
      type: json['type'] != null
          ? PromotionType.values.firstWhere(
              (e) => e.toString() == 'PromotionType.${json['type']}',
              orElse: () => PromotionType.AMOUNT,
            )
          : PromotionType.AMOUNT,
      amount: json['amount'] != null ? num.parse(json['amount'].toString()) : 0,
      maxUses: json['max_uses'] != null
          ? int.parse(json['max_uses'].toString())
          : null,
    );
  }

  final PromotionType type;
  final num amount;
  final int? maxUses;

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    return {
      ...json,
      'type': type.toString().split('.').last,
      'amount': amount.toString(),
      if (maxUses != null) 'max_uses': maxUses,
    };
  }
}
