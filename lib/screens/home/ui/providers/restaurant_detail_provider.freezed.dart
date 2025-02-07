// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_detail_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RestaurantDetailState {
  List<Restaurants>? get restaurants => throw _privateConstructorUsedError;
  List<MenuItems>? get menuItems => throw _privateConstructorUsedError;
  String? get restaurantId => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantDetailStateCopyWith<RestaurantDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantDetailStateCopyWith<$Res> {
  factory $RestaurantDetailStateCopyWith(RestaurantDetailState value,
          $Res Function(RestaurantDetailState) then) =
      _$RestaurantDetailStateCopyWithImpl<$Res, RestaurantDetailState>;
  @useResult
  $Res call(
      {List<Restaurants>? restaurants,
      List<MenuItems>? menuItems,
      String? restaurantId,
      bool isLoading});
}

/// @nodoc
class _$RestaurantDetailStateCopyWithImpl<$Res,
        $Val extends RestaurantDetailState>
    implements $RestaurantDetailStateCopyWith<$Res> {
  _$RestaurantDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurants = freezed,
    Object? menuItems = freezed,
    Object? restaurantId = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      restaurants: freezed == restaurants
          ? _value.restaurants
          : restaurants // ignore: cast_nullable_to_non_nullable
              as List<Restaurants>?,
      menuItems: freezed == menuItems
          ? _value.menuItems
          : menuItems // ignore: cast_nullable_to_non_nullable
              as List<MenuItems>?,
      restaurantId: freezed == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestaurantDetailStateImplCopyWith<$Res>
    implements $RestaurantDetailStateCopyWith<$Res> {
  factory _$$RestaurantDetailStateImplCopyWith(
          _$RestaurantDetailStateImpl value,
          $Res Function(_$RestaurantDetailStateImpl) then) =
      __$$RestaurantDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Restaurants>? restaurants,
      List<MenuItems>? menuItems,
      String? restaurantId,
      bool isLoading});
}

/// @nodoc
class __$$RestaurantDetailStateImplCopyWithImpl<$Res>
    extends _$RestaurantDetailStateCopyWithImpl<$Res,
        _$RestaurantDetailStateImpl>
    implements _$$RestaurantDetailStateImplCopyWith<$Res> {
  __$$RestaurantDetailStateImplCopyWithImpl(_$RestaurantDetailStateImpl _value,
      $Res Function(_$RestaurantDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RestaurantDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? restaurants = freezed,
    Object? menuItems = freezed,
    Object? restaurantId = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$RestaurantDetailStateImpl(
      restaurants: freezed == restaurants
          ? _value._restaurants
          : restaurants // ignore: cast_nullable_to_non_nullable
              as List<Restaurants>?,
      menuItems: freezed == menuItems
          ? _value._menuItems
          : menuItems // ignore: cast_nullable_to_non_nullable
              as List<MenuItems>?,
      restaurantId: freezed == restaurantId
          ? _value.restaurantId
          : restaurantId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RestaurantDetailStateImpl implements _RestaurantDetailState {
  const _$RestaurantDetailStateImpl(
      {final List<Restaurants>? restaurants,
      final List<MenuItems>? menuItems,
      this.restaurantId,
      this.isLoading = false})
      : _restaurants = restaurants,
        _menuItems = menuItems;

  final List<Restaurants>? _restaurants;
  @override
  List<Restaurants>? get restaurants {
    final value = _restaurants;
    if (value == null) return null;
    if (_restaurants is EqualUnmodifiableListView) return _restaurants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MenuItems>? _menuItems;
  @override
  List<MenuItems>? get menuItems {
    final value = _menuItems;
    if (value == null) return null;
    if (_menuItems is EqualUnmodifiableListView) return _menuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? restaurantId;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'RestaurantDetailState(restaurants: $restaurants, menuItems: $menuItems, restaurantId: $restaurantId, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantDetailStateImpl &&
            const DeepCollectionEquality()
                .equals(other._restaurants, _restaurants) &&
            const DeepCollectionEquality()
                .equals(other._menuItems, _menuItems) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_restaurants),
      const DeepCollectionEquality().hash(_menuItems),
      restaurantId,
      isLoading);

  /// Create a copy of RestaurantDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantDetailStateImplCopyWith<_$RestaurantDetailStateImpl>
      get copyWith => __$$RestaurantDetailStateImplCopyWithImpl<
          _$RestaurantDetailStateImpl>(this, _$identity);
}

abstract class _RestaurantDetailState implements RestaurantDetailState {
  const factory _RestaurantDetailState(
      {final List<Restaurants>? restaurants,
      final List<MenuItems>? menuItems,
      final String? restaurantId,
      final bool isLoading}) = _$RestaurantDetailStateImpl;

  @override
  List<Restaurants>? get restaurants;
  @override
  List<MenuItems>? get menuItems;
  @override
  String? get restaurantId;
  @override
  bool get isLoading;

  /// Create a copy of RestaurantDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantDetailStateImplCopyWith<_$RestaurantDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
