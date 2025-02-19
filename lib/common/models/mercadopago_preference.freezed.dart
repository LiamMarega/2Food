// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mercadopago_preference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MercadoPagoPreference _$MercadoPagoPreferenceFromJson(
    Map<String, dynamic> json) {
  return _MercadoPagoPreference.fromJson(json);
}

/// @nodoc
mixin _$MercadoPagoPreference {
  String get id => throw _privateConstructorUsedError;
  String get initPoint => throw _privateConstructorUsedError;
  String get sandboxInitPoint => throw _privateConstructorUsedError;

  /// Serializes this MercadoPagoPreference to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MercadoPagoPreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MercadoPagoPreferenceCopyWith<MercadoPagoPreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MercadoPagoPreferenceCopyWith<$Res> {
  factory $MercadoPagoPreferenceCopyWith(MercadoPagoPreference value,
          $Res Function(MercadoPagoPreference) then) =
      _$MercadoPagoPreferenceCopyWithImpl<$Res, MercadoPagoPreference>;
  @useResult
  $Res call({String id, String initPoint, String sandboxInitPoint});
}

/// @nodoc
class _$MercadoPagoPreferenceCopyWithImpl<$Res,
        $Val extends MercadoPagoPreference>
    implements $MercadoPagoPreferenceCopyWith<$Res> {
  _$MercadoPagoPreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MercadoPagoPreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? initPoint = null,
    Object? sandboxInitPoint = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      initPoint: null == initPoint
          ? _value.initPoint
          : initPoint // ignore: cast_nullable_to_non_nullable
              as String,
      sandboxInitPoint: null == sandboxInitPoint
          ? _value.sandboxInitPoint
          : sandboxInitPoint // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MercadoPagoPreferenceImplCopyWith<$Res>
    implements $MercadoPagoPreferenceCopyWith<$Res> {
  factory _$$MercadoPagoPreferenceImplCopyWith(
          _$MercadoPagoPreferenceImpl value,
          $Res Function(_$MercadoPagoPreferenceImpl) then) =
      __$$MercadoPagoPreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String initPoint, String sandboxInitPoint});
}

/// @nodoc
class __$$MercadoPagoPreferenceImplCopyWithImpl<$Res>
    extends _$MercadoPagoPreferenceCopyWithImpl<$Res,
        _$MercadoPagoPreferenceImpl>
    implements _$$MercadoPagoPreferenceImplCopyWith<$Res> {
  __$$MercadoPagoPreferenceImplCopyWithImpl(_$MercadoPagoPreferenceImpl _value,
      $Res Function(_$MercadoPagoPreferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MercadoPagoPreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? initPoint = null,
    Object? sandboxInitPoint = null,
  }) {
    return _then(_$MercadoPagoPreferenceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      initPoint: null == initPoint
          ? _value.initPoint
          : initPoint // ignore: cast_nullable_to_non_nullable
              as String,
      sandboxInitPoint: null == sandboxInitPoint
          ? _value.sandboxInitPoint
          : sandboxInitPoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MercadoPagoPreferenceImpl implements _MercadoPagoPreference {
  _$MercadoPagoPreferenceImpl(
      {required this.id,
      required this.initPoint,
      required this.sandboxInitPoint});

  factory _$MercadoPagoPreferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MercadoPagoPreferenceImplFromJson(json);

  @override
  final String id;
  @override
  final String initPoint;
  @override
  final String sandboxInitPoint;

  @override
  String toString() {
    return 'MercadoPagoPreference(id: $id, initPoint: $initPoint, sandboxInitPoint: $sandboxInitPoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MercadoPagoPreferenceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.initPoint, initPoint) ||
                other.initPoint == initPoint) &&
            (identical(other.sandboxInitPoint, sandboxInitPoint) ||
                other.sandboxInitPoint == sandboxInitPoint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, initPoint, sandboxInitPoint);

  /// Create a copy of MercadoPagoPreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MercadoPagoPreferenceImplCopyWith<_$MercadoPagoPreferenceImpl>
      get copyWith => __$$MercadoPagoPreferenceImplCopyWithImpl<
          _$MercadoPagoPreferenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MercadoPagoPreferenceImplToJson(
      this,
    );
  }
}

abstract class _MercadoPagoPreference implements MercadoPagoPreference {
  factory _MercadoPagoPreference(
      {required final String id,
      required final String initPoint,
      required final String sandboxInitPoint}) = _$MercadoPagoPreferenceImpl;

  factory _MercadoPagoPreference.fromJson(Map<String, dynamic> json) =
      _$MercadoPagoPreferenceImpl.fromJson;

  @override
  String get id;
  @override
  String get initPoint;
  @override
  String get sandboxInitPoint;

  /// Create a copy of MercadoPagoPreference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MercadoPagoPreferenceImplCopyWith<_$MercadoPagoPreferenceImpl>
      get copyWith => throw _privateConstructorUsedError;
}
