// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuTypeImpl _$$MenuTypeImplFromJson(Map<String, dynamic> json) =>
    _$MenuTypeImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      active: json['active'] as bool,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$$MenuTypeImplToJson(_$MenuTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'active': instance.active,
      'created_at': instance.created_at,
    };
