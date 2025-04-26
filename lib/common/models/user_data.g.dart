// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      created_at: json['created_at'] as String,
      photo: json['photo'] as String?,
      points: (json['points'] as num?)?.toInt(),
      role: json['role'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'created_at': instance.created_at,
      'photo': instance.photo,
      'points': instance.points,
      'role': instance.role,
      'phone': instance.phone,
      'name': instance.name,
    };
