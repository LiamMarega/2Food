// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuItemImpl _$$MenuItemImplFromJson(Map<String, dynamic> json) =>
    _$MenuItemImpl(
      id: json['id'] as String,
      restaurant_id: json['restaurant_id'] as String,
      name: json['name'] as String,
      price: json['price'] as num,
      description: json['description'] as String?,
      arContentUrl: json['arContentUrl'] as String?,
      isSignature: json['isSignature'] as bool?,
      trendingScore: (json['trendingScore'] as num?)?.toInt(),
      photo: json['photo'] as String?,
      promotions: (json['promotions'] as List<dynamic>?)
          ?.map((e) => Promotion.fromJson(e as Map<String, dynamic>))
          .toList(),
      menu_type: json['menu_type'] as String?,
    );

Map<String, dynamic> _$$MenuItemImplToJson(_$MenuItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant_id': instance.restaurant_id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'arContentUrl': instance.arContentUrl,
      'isSignature': instance.isSignature,
      'trendingScore': instance.trendingScore,
      'photo': instance.photo,
      'promotions': instance.promotions,
      'menu_type': instance.menu_type,
    };
