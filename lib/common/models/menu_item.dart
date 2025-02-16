import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.freezed.dart';
part 'menu_item.g.dart'; // Add this line to include the generated JSON serialization code

@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String restaurantId,
    required String name,
    required num price,
    String? description,
    String? arContentUrl,
    bool? isSignature,
    int? trendingScore,
    String? photo,
  }) = _MenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);
}
