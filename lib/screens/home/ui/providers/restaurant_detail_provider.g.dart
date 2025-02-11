// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restaurantDetailHash() => r'2e623240706692cfce5baf0bf7f0b41dfb4a9cd6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$RestaurantDetail
    extends BuildlessAsyncNotifier<RestaurantDetailState> {
  late final String restaurantId;

  FutureOr<RestaurantDetailState> build({
    required String restaurantId,
  });
}

/// See also [RestaurantDetail].
@ProviderFor(RestaurantDetail)
const restaurantDetailProvider = RestaurantDetailFamily();

/// See also [RestaurantDetail].
class RestaurantDetailFamily extends Family<AsyncValue<RestaurantDetailState>> {
  /// See also [RestaurantDetail].
  const RestaurantDetailFamily();

  /// See also [RestaurantDetail].
  RestaurantDetailProvider call({
    required String restaurantId,
  }) {
    return RestaurantDetailProvider(
      restaurantId: restaurantId,
    );
  }

  @override
  RestaurantDetailProvider getProviderOverride(
    covariant RestaurantDetailProvider provider,
  ) {
    return call(
      restaurantId: provider.restaurantId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'restaurantDetailProvider';
}

/// See also [RestaurantDetail].
class RestaurantDetailProvider
    extends AsyncNotifierProviderImpl<RestaurantDetail, RestaurantDetailState> {
  /// See also [RestaurantDetail].
  RestaurantDetailProvider({
    required String restaurantId,
  }) : this._internal(
          () => RestaurantDetail()..restaurantId = restaurantId,
          from: restaurantDetailProvider,
          name: r'restaurantDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$restaurantDetailHash,
          dependencies: RestaurantDetailFamily._dependencies,
          allTransitiveDependencies:
              RestaurantDetailFamily._allTransitiveDependencies,
          restaurantId: restaurantId,
        );

  RestaurantDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.restaurantId,
  }) : super.internal();

  final String restaurantId;

  @override
  FutureOr<RestaurantDetailState> runNotifierBuild(
    covariant RestaurantDetail notifier,
  ) {
    return notifier.build(
      restaurantId: restaurantId,
    );
  }

  @override
  Override overrideWith(RestaurantDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: RestaurantDetailProvider._internal(
        () => create()..restaurantId = restaurantId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        restaurantId: restaurantId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<RestaurantDetail, RestaurantDetailState>
      createElement() {
    return _RestaurantDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RestaurantDetailProvider &&
        other.restaurantId == restaurantId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, restaurantId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RestaurantDetailRef on AsyncNotifierProviderRef<RestaurantDetailState> {
  /// The parameter `restaurantId` of this provider.
  String get restaurantId;
}

class _RestaurantDetailProviderElement extends AsyncNotifierProviderElement<
    RestaurantDetail, RestaurantDetailState> with RestaurantDetailRef {
  _RestaurantDetailProviderElement(super.provider);

  @override
  String get restaurantId => (origin as RestaurantDetailProvider).restaurantId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
