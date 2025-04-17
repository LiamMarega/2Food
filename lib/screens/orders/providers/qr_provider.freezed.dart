// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QrState {
  bool get loading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  QrResponse? get qrData => throw _privateConstructorUsedError;

  /// Create a copy of QrState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QrStateCopyWith<QrState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrStateCopyWith<$Res> {
  factory $QrStateCopyWith(QrState value, $Res Function(QrState) then) =
      _$QrStateCopyWithImpl<$Res, QrState>;
  @useResult
  $Res call({bool loading, String? error, QrResponse? qrData});

  $QrResponseCopyWith<$Res>? get qrData;
}

/// @nodoc
class _$QrStateCopyWithImpl<$Res, $Val extends QrState>
    implements $QrStateCopyWith<$Res> {
  _$QrStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? error = freezed,
    Object? qrData = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of QrState
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
abstract class _$$QrStateImplCopyWith<$Res> implements $QrStateCopyWith<$Res> {
  factory _$$QrStateImplCopyWith(
          _$QrStateImpl value, $Res Function(_$QrStateImpl) then) =
      __$$QrStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, String? error, QrResponse? qrData});

  @override
  $QrResponseCopyWith<$Res>? get qrData;
}

/// @nodoc
class __$$QrStateImplCopyWithImpl<$Res>
    extends _$QrStateCopyWithImpl<$Res, _$QrStateImpl>
    implements _$$QrStateImplCopyWith<$Res> {
  __$$QrStateImplCopyWithImpl(
      _$QrStateImpl _value, $Res Function(_$QrStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? error = freezed,
    Object? qrData = freezed,
  }) {
    return _then(_$QrStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
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

class _$QrStateImpl implements _QrState {
  _$QrStateImpl({this.loading = false, this.error, this.qrData});

  @override
  @JsonKey()
  final bool loading;
  @override
  final String? error;
  @override
  final QrResponse? qrData;

  @override
  String toString() {
    return 'QrState(loading: $loading, error: $error, qrData: $qrData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.qrData, qrData) || other.qrData == qrData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, error, qrData);

  /// Create a copy of QrState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrStateImplCopyWith<_$QrStateImpl> get copyWith =>
      __$$QrStateImplCopyWithImpl<_$QrStateImpl>(this, _$identity);
}

abstract class _QrState implements QrState {
  factory _QrState(
      {final bool loading,
      final String? error,
      final QrResponse? qrData}) = _$QrStateImpl;

  @override
  bool get loading;
  @override
  String? get error;
  @override
  QrResponse? get qrData;

  /// Create a copy of QrState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrStateImplCopyWith<_$QrStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
