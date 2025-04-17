// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderState {
  Map<String, List<OrderItem>> get orders => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  QrResponse? get qrData => throw _privateConstructorUsedError;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderStateCopyWith<OrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
          OrderState value, $Res Function(OrderState) then) =
      _$OrderStateCopyWithImpl<$Res, OrderState>;
  @useResult
  $Res call(
      {Map<String, List<OrderItem>> orders,
      bool isLoading,
      String? error,
      QrResponse? qrData});

  $QrResponseCopyWith<$Res>? get qrData;
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res, $Val extends OrderState>
    implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? qrData = freezed,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as Map<String, List<OrderItem>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      qrData: freezed == qrData
          ? _value.qrData
          : qrData // ignore: cast_nullable_to_non_nullable
              as QrResponse?,
    ) as $Val);
  }

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QrResponseCopyWith<$Res>? get qrData {
    if (_value.qrData == null) {
      return null;
    }

    return $QrResponseCopyWith<$Res>(_value.qrData!, (value) {
      return _then(_value.copyWith(qrData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderStateImplCopyWith<$Res>
    implements $OrderStateCopyWith<$Res> {
  factory _$$OrderStateImplCopyWith(
          _$OrderStateImpl value, $Res Function(_$OrderStateImpl) then) =
      __$$OrderStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<OrderItem>> orders,
      bool isLoading,
      String? error,
      QrResponse? qrData});

  @override
  $QrResponseCopyWith<$Res>? get qrData;
}

/// @nodoc
class __$$OrderStateImplCopyWithImpl<$Res>
    extends _$OrderStateCopyWithImpl<$Res, _$OrderStateImpl>
    implements _$$OrderStateImplCopyWith<$Res> {
  __$$OrderStateImplCopyWithImpl(
      _$OrderStateImpl _value, $Res Function(_$OrderStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? qrData = freezed,
  }) {
    return _then(_$OrderStateImpl(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as Map<String, List<OrderItem>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      qrData: freezed == qrData
          ? _value.qrData
          : qrData // ignore: cast_nullable_to_non_nullable
              as QrResponse?,
    ));
  }
}

/// @nodoc

class _$OrderStateImpl implements _OrderState {
  _$OrderStateImpl(
      {required final Map<String, List<OrderItem>> orders,
      this.isLoading = false,
      this.error,
      this.qrData})
      : _orders = orders;

  final Map<String, List<OrderItem>> _orders;
  @override
  Map<String, List<OrderItem>> get orders {
    if (_orders is EqualUnmodifiableMapView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_orders);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final QrResponse? qrData;

  @override
  String toString() {
    return 'OrderState(orders: $orders, isLoading: $isLoading, error: $error, qrData: $qrData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStateImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.qrData, qrData) || other.qrData == qrData));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_orders), isLoading, error, qrData);

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      __$$OrderStateImplCopyWithImpl<_$OrderStateImpl>(this, _$identity);
}

abstract class _OrderState implements OrderState {
  factory _OrderState(
      {required final Map<String, List<OrderItem>> orders,
      final bool isLoading,
      final String? error,
      final QrResponse? qrData}) = _$OrderStateImpl;

  @override
  Map<String, List<OrderItem>> get orders;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  QrResponse? get qrData;

  /// Create a copy of OrderState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderStateImplCopyWith<_$OrderStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
