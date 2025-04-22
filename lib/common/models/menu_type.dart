import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_type.freezed.dart';
part 'menu_type.g.dart';

@freezed
class MenuType with _$MenuType {
  const factory MenuType({
    required String id,
    required String type,
    required bool active,
    String? created_at,
  }) = _MenuType;

  factory MenuType.fromJson(Map<String, dynamic> json) =>
      _$MenuTypeFromJson(json);

  static List<MenuType> converter(List<dynamic> data) {
    return data
        .map((item) => MenuType.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
