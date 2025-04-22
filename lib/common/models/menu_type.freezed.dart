// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MenuType _$MenuTypeFromJson(Map<String, dynamic> json) {
  return _MenuType.fromJson(json);
}

/// @nodoc
mixin _$MenuType {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;

  /// Serializes this MenuType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MenuType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuTypeCopyWith<MenuType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuTypeCopyWith<$Res> {
  factory $MenuTypeCopyWith(MenuType value, $Res Function(MenuType) then) =
      _$MenuTypeCopyWithImpl<$Res, MenuType>;
  @useResult
  $Res call({String id, String type, bool active, String? created_at});
}

/// @nodoc
class _$MenuTypeCopyWithImpl<$Res, $Val extends MenuType>
    implements $MenuTypeCopyWith<$Res> {
  _$MenuTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? active = null,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuTypeImplCopyWith<$Res>
    implements $MenuTypeCopyWith<$Res> {
  factory _$$MenuTypeImplCopyWith(
          _$MenuTypeImpl value, $Res Function(_$MenuTypeImpl) then) =
      __$$MenuTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String type, bool active, String? created_at});
}

/// @nodoc
class __$$MenuTypeImplCopyWithImpl<$Res>
    extends _$MenuTypeCopyWithImpl<$Res, _$MenuTypeImpl>
    implements _$$MenuTypeImplCopyWith<$Res> {
  __$$MenuTypeImplCopyWithImpl(
      _$MenuTypeImpl _value, $Res Function(_$MenuTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of MenuType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? active = null,
    Object? created_at = freezed,
  }) {
    return _then(_$MenuTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MenuTypeImpl implements _MenuType {
  const _$MenuTypeImpl(
      {required this.id,
      required this.type,
      required this.active,
      this.created_at});

  factory _$MenuTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MenuTypeImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final bool active;
  @override
  final String? created_at;

  @override
  String toString() {
    return 'MenuType(id: $id, type: $type, active: $active, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, active, created_at);

  /// Create a copy of MenuType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuTypeImplCopyWith<_$MenuTypeImpl> get copyWith =>
      __$$MenuTypeImplCopyWithImpl<_$MenuTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MenuTypeImplToJson(
      this,
    );
  }
}

abstract class _MenuType implements MenuType {
  const factory _MenuType(
      {required final String id,
      required final String type,
      required final bool active,
      final String? created_at}) = _$MenuTypeImpl;

  factory _MenuType.fromJson(Map<String, dynamic> json) =
      _$MenuTypeImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  bool get active;
  @override
  String? get created_at;

  /// Create a copy of MenuType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuTypeImplCopyWith<_$MenuTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
