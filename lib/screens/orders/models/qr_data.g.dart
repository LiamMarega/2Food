// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QrResponseImpl _$$QrResponseImplFromJson(Map<String, dynamic> json) =>
    _$QrResponseImpl(
      order_hash: json['order_hash'] as String,
      signature: json['signature'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$QrResponseImplToJson(_$QrResponseImpl instance) =>
    <String, dynamic>{
      'order_hash': instance.order_hash,
      'signature': instance.signature,
      'timestamp': instance.timestamp.toIso8601String(),
    };
