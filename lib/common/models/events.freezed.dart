// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get banner => throw _privateConstructorUsedError;
  int? get users_joined => throw _privateConstructorUsedError;
  List<String>? get users => throw _privateConstructorUsedError;
  int? get max_users => throw _privateConstructorUsedError;
  int? get min_age => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  Map<String, dynamic>? get location_coordinates =>
      throw _privateConstructorUsedError;
  bool? get is_secret_location => throw _privateConstructorUsedError;
  bool? get secret_menu => throw _privateConstructorUsedError;
  bool? get secret_attendees => throw _privateConstructorUsedError;
  String? get event_type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get custom_variables =>
      throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  DateTime get updated_at => throw _privateConstructorUsedError;
  String? get cancellation_reason => throw _privateConstructorUsedError;

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      DateTime date,
      String? banner,
      int? users_joined,
      List<String>? users,
      int? max_users,
      int? min_age,
      double? price,
      String? currency,
      String? location,
      Map<String, dynamic>? location_coordinates,
      bool? is_secret_location,
      bool? secret_menu,
      bool? secret_attendees,
      String? event_type,
      Map<String, dynamic>? custom_variables,
      List<String>? tags,
      String? status,
      DateTime created_at,
      DateTime updated_at,
      String? cancellation_reason});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? date = null,
    Object? banner = freezed,
    Object? users_joined = freezed,
    Object? users = freezed,
    Object? max_users = freezed,
    Object? min_age = freezed,
    Object? price = freezed,
    Object? currency = freezed,
    Object? location = freezed,
    Object? location_coordinates = freezed,
    Object? is_secret_location = freezed,
    Object? secret_menu = freezed,
    Object? secret_attendees = freezed,
    Object? event_type = freezed,
    Object? custom_variables = freezed,
    Object? tags = freezed,
    Object? status = freezed,
    Object? created_at = null,
    Object? updated_at = null,
    Object? cancellation_reason = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      users_joined: freezed == users_joined
          ? _value.users_joined
          : users_joined // ignore: cast_nullable_to_non_nullable
              as int?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      max_users: freezed == max_users
          ? _value.max_users
          : max_users // ignore: cast_nullable_to_non_nullable
              as int?,
      min_age: freezed == min_age
          ? _value.min_age
          : min_age // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      location_coordinates: freezed == location_coordinates
          ? _value.location_coordinates
          : location_coordinates // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      is_secret_location: freezed == is_secret_location
          ? _value.is_secret_location
          : is_secret_location // ignore: cast_nullable_to_non_nullable
              as bool?,
      secret_menu: freezed == secret_menu
          ? _value.secret_menu
          : secret_menu // ignore: cast_nullable_to_non_nullable
              as bool?,
      secret_attendees: freezed == secret_attendees
          ? _value.secret_attendees
          : secret_attendees // ignore: cast_nullable_to_non_nullable
              as bool?,
      event_type: freezed == event_type
          ? _value.event_type
          : event_type // ignore: cast_nullable_to_non_nullable
              as String?,
      custom_variables: freezed == custom_variables
          ? _value.custom_variables
          : custom_variables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated_at: null == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cancellation_reason: freezed == cancellation_reason
          ? _value.cancellation_reason
          : cancellation_reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      DateTime date,
      String? banner,
      int? users_joined,
      List<String>? users,
      int? max_users,
      int? min_age,
      double? price,
      String? currency,
      String? location,
      Map<String, dynamic>? location_coordinates,
      bool? is_secret_location,
      bool? secret_menu,
      bool? secret_attendees,
      String? event_type,
      Map<String, dynamic>? custom_variables,
      List<String>? tags,
      String? status,
      DateTime created_at,
      DateTime updated_at,
      String? cancellation_reason});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? date = null,
    Object? banner = freezed,
    Object? users_joined = freezed,
    Object? users = freezed,
    Object? max_users = freezed,
    Object? min_age = freezed,
    Object? price = freezed,
    Object? currency = freezed,
    Object? location = freezed,
    Object? location_coordinates = freezed,
    Object? is_secret_location = freezed,
    Object? secret_menu = freezed,
    Object? secret_attendees = freezed,
    Object? event_type = freezed,
    Object? custom_variables = freezed,
    Object? tags = freezed,
    Object? status = freezed,
    Object? created_at = null,
    Object? updated_at = null,
    Object? cancellation_reason = freezed,
  }) {
    return _then(_$EventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      users_joined: freezed == users_joined
          ? _value.users_joined
          : users_joined // ignore: cast_nullable_to_non_nullable
              as int?,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      max_users: freezed == max_users
          ? _value.max_users
          : max_users // ignore: cast_nullable_to_non_nullable
              as int?,
      min_age: freezed == min_age
          ? _value.min_age
          : min_age // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      location_coordinates: freezed == location_coordinates
          ? _value._location_coordinates
          : location_coordinates // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      is_secret_location: freezed == is_secret_location
          ? _value.is_secret_location
          : is_secret_location // ignore: cast_nullable_to_non_nullable
              as bool?,
      secret_menu: freezed == secret_menu
          ? _value.secret_menu
          : secret_menu // ignore: cast_nullable_to_non_nullable
              as bool?,
      secret_attendees: freezed == secret_attendees
          ? _value.secret_attendees
          : secret_attendees // ignore: cast_nullable_to_non_nullable
              as bool?,
      event_type: freezed == event_type
          ? _value.event_type
          : event_type // ignore: cast_nullable_to_non_nullable
              as String?,
      custom_variables: freezed == custom_variables
          ? _value._custom_variables
          : custom_variables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated_at: null == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cancellation_reason: freezed == cancellation_reason
          ? _value.cancellation_reason
          : cancellation_reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl with DiagnosticableTreeMixin implements _Event {
  const _$EventImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      this.banner,
      this.users_joined,
      final List<String>? users,
      this.max_users,
      this.min_age,
      this.price,
      this.currency,
      this.location,
      final Map<String, dynamic>? location_coordinates,
      this.is_secret_location,
      this.secret_menu,
      this.secret_attendees,
      this.event_type,
      final Map<String, dynamic>? custom_variables,
      final List<String>? tags,
      this.status,
      required this.created_at,
      required this.updated_at,
      this.cancellation_reason})
      : _users = users,
        _location_coordinates = location_coordinates,
        _custom_variables = custom_variables,
        _tags = tags;

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final DateTime date;
  @override
  final String? banner;
  @override
  final int? users_joined;
  final List<String>? _users;
  @override
  List<String>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? max_users;
  @override
  final int? min_age;
  @override
  final double? price;
  @override
  final String? currency;
  @override
  final String? location;
  final Map<String, dynamic>? _location_coordinates;
  @override
  Map<String, dynamic>? get location_coordinates {
    final value = _location_coordinates;
    if (value == null) return null;
    if (_location_coordinates is EqualUnmodifiableMapView)
      return _location_coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? is_secret_location;
  @override
  final bool? secret_menu;
  @override
  final bool? secret_attendees;
  @override
  final String? event_type;
  final Map<String, dynamic>? _custom_variables;
  @override
  Map<String, dynamic>? get custom_variables {
    final value = _custom_variables;
    if (value == null) return null;
    if (_custom_variables is EqualUnmodifiableMapView) return _custom_variables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? status;
  @override
  final DateTime created_at;
  @override
  final DateTime updated_at;
  @override
  final String? cancellation_reason;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Event(id: $id, name: $name, description: $description, date: $date, banner: $banner, users_joined: $users_joined, users: $users, max_users: $max_users, min_age: $min_age, price: $price, currency: $currency, location: $location, location_coordinates: $location_coordinates, is_secret_location: $is_secret_location, secret_menu: $secret_menu, secret_attendees: $secret_attendees, event_type: $event_type, custom_variables: $custom_variables, tags: $tags, status: $status, created_at: $created_at, updated_at: $updated_at, cancellation_reason: $cancellation_reason)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Event'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('banner', banner))
      ..add(DiagnosticsProperty('users_joined', users_joined))
      ..add(DiagnosticsProperty('users', users))
      ..add(DiagnosticsProperty('max_users', max_users))
      ..add(DiagnosticsProperty('min_age', min_age))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('currency', currency))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('location_coordinates', location_coordinates))
      ..add(DiagnosticsProperty('is_secret_location', is_secret_location))
      ..add(DiagnosticsProperty('secret_menu', secret_menu))
      ..add(DiagnosticsProperty('secret_attendees', secret_attendees))
      ..add(DiagnosticsProperty('event_type', event_type))
      ..add(DiagnosticsProperty('custom_variables', custom_variables))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('created_at', created_at))
      ..add(DiagnosticsProperty('updated_at', updated_at))
      ..add(DiagnosticsProperty('cancellation_reason', cancellation_reason));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.users_joined, users_joined) ||
                other.users_joined == users_joined) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.max_users, max_users) ||
                other.max_users == max_users) &&
            (identical(other.min_age, min_age) || other.min_age == min_age) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._location_coordinates, _location_coordinates) &&
            (identical(other.is_secret_location, is_secret_location) ||
                other.is_secret_location == is_secret_location) &&
            (identical(other.secret_menu, secret_menu) ||
                other.secret_menu == secret_menu) &&
            (identical(other.secret_attendees, secret_attendees) ||
                other.secret_attendees == secret_attendees) &&
            (identical(other.event_type, event_type) ||
                other.event_type == event_type) &&
            const DeepCollectionEquality()
                .equals(other._custom_variables, _custom_variables) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.cancellation_reason, cancellation_reason) ||
                other.cancellation_reason == cancellation_reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        date,
        banner,
        users_joined,
        const DeepCollectionEquality().hash(_users),
        max_users,
        min_age,
        price,
        currency,
        location,
        const DeepCollectionEquality().hash(_location_coordinates),
        is_secret_location,
        secret_menu,
        secret_attendees,
        event_type,
        const DeepCollectionEquality().hash(_custom_variables),
        const DeepCollectionEquality().hash(_tags),
        status,
        created_at,
        updated_at,
        cancellation_reason
      ]);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String id,
      required final String name,
      required final String description,
      required final DateTime date,
      final String? banner,
      final int? users_joined,
      final List<String>? users,
      final int? max_users,
      final int? min_age,
      final double? price,
      final String? currency,
      final String? location,
      final Map<String, dynamic>? location_coordinates,
      final bool? is_secret_location,
      final bool? secret_menu,
      final bool? secret_attendees,
      final String? event_type,
      final Map<String, dynamic>? custom_variables,
      final List<String>? tags,
      final String? status,
      required final DateTime created_at,
      required final DateTime updated_at,
      final String? cancellation_reason}) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  DateTime get date;
  @override
  String? get banner;
  @override
  int? get users_joined;
  @override
  List<String>? get users;
  @override
  int? get max_users;
  @override
  int? get min_age;
  @override
  double? get price;
  @override
  String? get currency;
  @override
  String? get location;
  @override
  Map<String, dynamic>? get location_coordinates;
  @override
  bool? get is_secret_location;
  @override
  bool? get secret_menu;
  @override
  bool? get secret_attendees;
  @override
  String? get event_type;
  @override
  Map<String, dynamic>? get custom_variables;
  @override
  List<String>? get tags;
  @override
  String? get status;
  @override
  DateTime get created_at;
  @override
  DateTime get updated_at;
  @override
  String? get cancellation_reason;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
