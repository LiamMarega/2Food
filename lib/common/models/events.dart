import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'events.freezed.dart';
part 'events.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String name,
    required String description,
    required DateTime date,
    String? banner,
    int? users_joined,
    List<String>? users,
    int? max_users,
    int? min_age,
    double? price,
    String? currency,
    String? location,
    Map<String, dynamic>? location_coordinates,
    bool? is_secret_location,
    bool? secret_menu,
    bool? secret_attendees,
    String? event_type,
    Map<String, dynamic>? custom_variables,
    List<String>? tags,
    String? status,
    required DateTime created_at,
    required DateTime updated_at,
    String? cancellation_reason,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  static List<Event> converter(dynamic data) {
    final result = <Event>[];
    try {
      for (final item in data as List<dynamic>) {
        try {
          final eventJson = item as Map<String, dynamic>;
          log('Processing event: ${eventJson['name']}');

          // Handle users array that might be null or of wrong type
          if (eventJson['users'] != null &&
              eventJson['users'] is! List<String>) {
            if (eventJson['users'] is List) {
              eventJson['users'] = (eventJson['users'] as List)
                  .map((e) => e.toString())
                  .toList();
            } else {
              eventJson['users'] = <String>[];
            }
          }

          // Handle tags array that might be null or of wrong type
          if (eventJson['tags'] != null && eventJson['tags'] is! List<String>) {
            if (eventJson['tags'] is List) {
              eventJson['tags'] =
                  (eventJson['tags'] as List).map((e) => e.toString()).toList();
            } else {
              eventJson['tags'] = <String>[];
            }
          }

          result.add(Event.fromJson(eventJson));
        } catch (e, stack) {
          log('Error converting individual event: $e\n$stack');
          // Continue processing other events
        }
      }
    } catch (e, stack) {
      log('Error in converter: $e\n$stack');
    }
    return result;
  }
}
