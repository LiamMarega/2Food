import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart'; // Add this line to include the generated JSON serialization code

@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String restaurant_id,
    required String name,
    required num price,
    String? description,
    String? arContentUrl,
    bool? isSignature,
    int? trendingScore,
    String? photo,
    List<Promotion>? promotions,
    String? menu_type,
  }) = _MenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
}

class Promotion {
  final String id;
  final String type;
  final num amount;
  final DateTime? endTime;
  final int? maxUses;
  final DateTime startTime;
  final String? description;
  final String menuItemId;

  Promotion({
    required this.id,
    required this.type,
    required this.amount,
    required this.startTime,
    required this.menuItemId,
    this.endTime,
    this.maxUses,
    this.description,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: json['amount'] as num,
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'] as String)
          : null,
      maxUses: json['max_uses'] as int?,
      startTime: DateTime.parse(json['start_time'] as String),
      description: json['description'] as String?,
      menuItemId: json['menu_item_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'end_time': endTime?.toIso8601String(),
      'max_uses': maxUses,
      'start_time': startTime.toIso8601String(),
      'description': description,
      'menu_item_id': menuItemId,
    };
  }
}
