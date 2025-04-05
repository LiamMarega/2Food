// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      banner: json['banner'] as String?,
      users_joined: (json['users_joined'] as num?)?.toInt(),
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      max_users: (json['max_users'] as num?)?.toInt(),
      min_age: (json['min_age'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      location: json['location'] as String?,
      location_coordinates:
          json['location_coordinates'] as Map<String, dynamic>?,
      is_secret_location: json['is_secret_location'] as bool?,
      secret_menu: json['secret_menu'] as bool?,
      secret_attendees: json['secret_attendees'] as bool?,
      event_type: json['event_type'] as String?,
      custom_variables: json['custom_variables'] as Map<String, dynamic>?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: json['status'] as String?,
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: DateTime.parse(json['updated_at'] as String),
      cancellation_reason: json['cancellation_reason'] as String?,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'banner': instance.banner,
      'users_joined': instance.users_joined,
      'users': instance.users,
      'max_users': instance.max_users,
      'min_age': instance.min_age,
      'price': instance.price,
      'currency': instance.currency,
      'location': instance.location,
      'location_coordinates': instance.location_coordinates,
      'is_secret_location': instance.is_secret_location,
      'secret_menu': instance.secret_menu,
      'secret_attendees': instance.secret_attendees,
      'event_type': instance.event_type,
      'custom_variables': instance.custom_variables,
      'tags': instance.tags,
      'status': instance.status,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at.toIso8601String(),
      'cancellation_reason': instance.cancellation_reason,
    };
