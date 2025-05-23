// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthSocialState {
  String? get error => throw _privateConstructorUsedError;
  bool get canContinue => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of AuthSocialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthSocialStateCopyWith<AuthSocialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSocialStateCopyWith<$Res> {
  factory $AuthSocialStateCopyWith(
          AuthSocialState value, $Res Function(AuthSocialState) then) =
      _$AuthSocialStateCopyWithImpl<$Res, AuthSocialState>;
  @useResult
  $Res call({String? error, bool canContinue, bool loading});
}

/// @nodoc
class _$AuthSocialStateCopyWithImpl<$Res, $Val extends AuthSocialState>
    implements $AuthSocialStateCopyWith<$Res> {
  _$AuthSocialStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthSocialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? canContinue = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      canContinue: null == canContinue
          ? _value.canContinue
          : canContinue // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthSocialStateImplCopyWith<$Res>
    implements $AuthSocialStateCopyWith<$Res> {
  factory _$$AuthSocialStateImplCopyWith(_$AuthSocialStateImpl value,
          $Res Function(_$AuthSocialStateImpl) then) =
      __$$AuthSocialStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? error, bool canContinue, bool loading});
}

/// @nodoc
class __$$AuthSocialStateImplCopyWithImpl<$Res>
    extends _$AuthSocialStateCopyWithImpl<$Res, _$AuthSocialStateImpl>
    implements _$$AuthSocialStateImplCopyWith<$Res> {
  __$$AuthSocialStateImplCopyWithImpl(
      _$AuthSocialStateImpl _value, $Res Function(_$AuthSocialStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthSocialState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? canContinue = null,
    Object? loading = null,
  }) {
    return _then(_$AuthSocialStateImpl(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      canContinue: null == canContinue
          ? _value.canContinue
          : canContinue // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthSocialStateImpl implements _AuthSocialState {
  _$AuthSocialStateImpl(
      {this.error, this.canContinue = false, this.loading = false});

  @override
  final String? error;
  @override
  @JsonKey()
  final bool canContinue;
  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'AuthSocialState(error: $error, canContinue: $canContinue, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSocialStateImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.canContinue, canContinue) ||
                other.canContinue == canContinue) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, canContinue, loading);

  /// Create a copy of AuthSocialState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSocialStateImplCopyWith<_$AuthSocialStateImpl> get copyWith =>
      __$$AuthSocialStateImplCopyWithImpl<_$AuthSocialStateImpl>(
          this, _$identity);
}

abstract class _AuthSocialState implements AuthSocialState {
  factory _AuthSocialState(
      {final String? error,
      final bool canContinue,
      final bool loading}) = _$AuthSocialStateImpl;

  @override
  String? get error;
  @override
  bool get canContinue;
  @override
  bool get loading;

  /// Create a copy of AuthSocialState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSocialStateImplCopyWith<_$AuthSocialStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
