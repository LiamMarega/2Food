// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QrResponse _$QrResponseFromJson(Map<String, dynamic> json) {
  return _QrResponse.fromJson(json);
}

/// @nodoc
mixin _$QrResponse {
  String get order_hash => throw _privateConstructorUsedError;
  String get signature => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this QrResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QrResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrResponseCopyWith<QrResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrResponseCopyWith<$Res> {
  factory $QrResponseCopyWith(
          QrResponse value, $Res Function(QrResponse) then) =
      _$QrResponseCopyWithImpl<$Res, QrResponse>;
  @useResult
  $Res call({String order_hash, String signature, DateTime timestamp});
}

/// @nodoc
class _$QrResponseCopyWithImpl<$Res, $Val extends QrResponse>
    implements $QrResponseCopyWith<$Res> {
  _$QrResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order_hash = null,
    Object? signature = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      order_hash: null == order_hash
          ? _value.order_hash
          : order_hash // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QrResponseImplCopyWith<$Res>
    implements $QrResponseCopyWith<$Res> {
  factory _$$QrResponseImplCopyWith(
          _$QrResponseImpl value, $Res Function(_$QrResponseImpl) then) =
      __$$QrResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String order_hash, String signature, DateTime timestamp});
}

/// @nodoc
class __$$QrResponseImplCopyWithImpl<$Res>
    extends _$QrResponseCopyWithImpl<$Res, _$QrResponseImpl>
    implements _$$QrResponseImplCopyWith<$Res> {
  __$$QrResponseImplCopyWithImpl(
      _$QrResponseImpl _value, $Res Function(_$QrResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order_hash = null,
    Object? signature = null,
    Object? timestamp = null,
  }) {
    return _then(_$QrResponseImpl(
      order_hash: null == order_hash
          ? _value.order_hash
          : order_hash // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QrResponseImpl implements _QrResponse {
  _$QrResponseImpl(
      {required this.order_hash,
      required this.signature,
      required this.timestamp});

  factory _$QrResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QrResponseImplFromJson(json);

  @override
  final String order_hash;
  @override
  final String signature;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'QrResponse(order_hash: $order_hash, signature: $signature, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrResponseImpl &&
            (identical(other.order_hash, order_hash) ||
                other.order_hash == order_hash) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, order_hash, signature, timestamp);

  /// Create a copy of QrResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrResponseImplCopyWith<_$QrResponseImpl> get copyWith =>
      __$$QrResponseImplCopyWithImpl<_$QrResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QrResponseImplToJson(
      this,
    );
  }
}

abstract class _QrResponse implements QrResponse {
  factory _QrResponse(
      {required final String order_hash,
      required final String signature,
      required final DateTime timestamp}) = _$QrResponseImpl;

  factory _QrResponse.fromJson(Map<String, dynamic> json) =
      _$QrResponseImpl.fromJson;

  @override
  String get order_hash;
  @override
  String get signature;
  @override
  DateTime get timestamp;

  /// Create a copy of QrResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrResponseImplCopyWith<_$QrResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
