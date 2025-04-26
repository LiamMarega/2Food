import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String id,
    required String email,
    required String created_at,
    String? photo,
    int? points,
    String? role,
    String? phone,
    String? name,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  static List<UserData> converter(dynamic data) {
    final result = <UserData>[];
    try {
      for (final item in data as List<dynamic>) {
        try {
          final userJson = item as Map<String, dynamic>;
          log('Processing user: ${userJson['email']}');
          result.add(UserData.fromJson(userJson));
        } catch (e, stack) {
          log('Error converting individual user: $e\n$stack');
          // Continue processing other users
        }
      }
    } catch (e, stack) {
      log('Error in converter: $e\n$stack');
    }
    return result;
  }
}
