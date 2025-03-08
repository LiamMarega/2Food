// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return _MenuItem.fromJson(json);
}

/// @nodoc
mixin _$MenuItem {
  String get id => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  num get price => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get arContentUrl => throw _privateConstructorUsedError;
  bool? get isSignature => throw _privateConstructorUsedError;
  int? get trendingScore => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  List<Promotion>? get promotions => throw _privateConstructorUsedError;

  /// Serializes this MenuItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuItemCopyWith<MenuItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemCopyWith<$Res> {
  factory $MenuItemCopyWith(MenuItem value, $Res Function(MenuItem) then) =
      _$MenuItemCopyWithImpl<$Res, MenuItem>;
  @useResult
  $Res call(
      {String id,
      String restaurantId,
      String name,
      num price,
      String? description,
      String? arContentUrl,
      bool? isSignature,
      int? trendingScore,
      String? photo,
      List<Promotion>? promotions});
}

/// @nodoc
class _$MenuItemCopyWithImpl<$Res, $Val extends MenuItem>
    implements $MenuItemCopyWith<$Res> {
  _$MenuItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? name = null,
    Object? price = null,
    Object? description = freezed,
    Object? arContentUrl = freezed,
    Object? isSignature = freezed,
    Object? trendingScore = freezed,
    Object? photo = freezed,
    Object? promotions = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      arContentUrl: freezed == arContentUrl
          ? _value.arContentUrl
          : arContentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isSignature: freezed == isSignature
          ? _value.isSignature
          : isSignature // ignore: cast_nullable_to_non_nullable
              as bool?,
      trendingScore: freezed == trendingScore
          ? _value.trendingScore
          : trendingScore // ignore: cast_nullable_to_non_nullable
              as int?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      promotions: freezed == promotions
          ? _value.promotions
          : promotions // ignore: cast_nullable_to_non_nullable
              as List<Promotion>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuItemImplCopyWith<$Res>
    implements $MenuItemCopyWith<$Res> {
  factory _$$MenuItemImplCopyWith(
          _$MenuItemImpl value, $Res Function(_$MenuItemImpl) then) =
      __$$MenuItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String restaurantId,
      String name,
      num price,
      String? description,
      String? arContentUrl,
      bool? isSignature,
      int? trendingScore,
      String? photo,
      List<Promotion>? promotions});
}

/// @nodoc
class __$$MenuItemImplCopyWithImpl<$Res>
    extends _$MenuItemCopyWithImpl<$Res, _$MenuItemImpl>
    implements _$$MenuItemImplCopyWith<$Res> {
  __$$MenuItemImplCopyWithImpl(
      _$MenuItemImpl _value, $Res Function(_$MenuItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? name = null,
    Object? price = null,
    Object? description = freezed,
    Object? arContentUrl = freezed,
    Object? isSignature = freezed,
    Object? trendingScore = freezed,
    Object? photo = freezed,
    Object? promotions = freezed,
  }) {
    return _then(_$MenuItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      restaurantId: null == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      arContentUrl: freezed == arContentUrl
          ? _value.arContentUrl
          : arContentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isSignature: freezed == isSignature
          ? _value.isSignature
          : isSignature // ignore: cast_nullable_to_non_nullable
              as bool?,
      trendingScore: freezed == trendingScore
          ? _value.trendingScore
          : trendingScore // ignore: cast_nullable_to_non_nullable
              as int?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      promotions: freezed == promotions
          ? _value._promotions
          : promotions // ignore: cast_nullable_to_non_nullable
              as List<Promotion>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuItemImpl implements _MenuItem {
  const _$MenuItemImpl(
      {required this.id,
      required this.restaurantId,
      required this.name,
      required this.price,
      this.description,
      this.arContentUrl,
      this.isSignature,
      this.trendingScore,
      this.photo,
      final List<Promotion>? promotions})
      : _promotions = promotions;

  factory _$MenuItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuItemImplFromJson(json);

  @override
  final String id;
  @override
  final String restaurantId;
  @override
  final String name;
  @override
  final num price;
  @override
  final String? description;
  @override
  final String? arContentUrl;
  @override
  final bool? isSignature;
  @override
  final int? trendingScore;
  @override
  final String? photo;
  final List<Promotion>? _promotions;
  @override
  List<Promotion>? get promotions {
    final value = _promotions;
    if (value == null) return null;
    if (_promotions is EqualUnmodifiableListView) return _promotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MenuItem(id: $id, restaurantId: $restaurantId, name: $name, price: $price, description: $description, arContentUrl: $arContentUrl, isSignature: $isSignature, trendingScore: $trendingScore, photo: $photo, promotions: $promotions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.arContentUrl, arContentUrl) ||
                other.arContentUrl == arContentUrl) &&
            (identical(other.isSignature, isSignature) ||
                other.isSignature == isSignature) &&
            (identical(other.trendingScore, trendingScore) ||
                other.trendingScore == trendingScore) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            const DeepCollectionEquality()
                .equals(other._promotions, _promotions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      restaurantId,
      name,
      price,
      description,
      arContentUrl,
      isSignature,
      trendingScore,
      photo,
      const DeepCollectionEquality().hash(_promotions));

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      __$$MenuItemImplCopyWithImpl<_$MenuItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuItemImplToJson(
      this,
    );
  }
}

abstract class _MenuItem implements MenuItem {
  const factory _MenuItem(
      {required final String id,
      required final String restaurantId,
      required final String name,
      required final num price,
      final String? description,
      final String? arContentUrl,
      final bool? isSignature,
      final int? trendingScore,
      final String? photo,
      final List<Promotion>? promotions}) = _$MenuItemImpl;

  factory _MenuItem.fromJson(Map<String, dynamic> json) =
      _$MenuItemImpl.fromJson;

  @override
  String get id;
  @override
  String get restaurantId;
  @override
  String get name;
  @override
  num get price;
  @override
  String? get description;
  @override
  String? get arContentUrl;
  @override
  bool? get isSignature;
  @override
  int? get trendingScore;
  @override
  String? get photo;
  @override
  List<Promotion>? get promotions;

  /// Create a copy of MenuItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuItemImplCopyWith<_$MenuItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
