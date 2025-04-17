// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$qrHash() => r'8407c924b46c7c291c292b2f38d3fe89ff64c985';

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

abstract class _$Qr extends BuildlessAutoDisposeNotifier<QrState> {
  late final String orderHash;

  QrState build(
    String orderHash,
  );
}

/// See also [Qr].
@ProviderFor(Qr)
const qrProvider = QrFamily();

/// See also [Qr].
class QrFamily extends Family<QrState> {
  /// See also [Qr].
  const QrFamily();

  /// See also [Qr].
  QrProvider call(
    String orderHash,
  ) {
    return QrProvider(
      orderHash,
    );
  }

  @override
  QrProvider getProviderOverride(
    covariant QrProvider provider,
  ) {
    return call(
      provider.orderHash,
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
  String? get name => r'qrProvider';
}

/// See also [Qr].
class QrProvider extends AutoDisposeNotifierProviderImpl<Qr, QrState> {
  /// See also [Qr].
  QrProvider(
    String orderHash,
  ) : this._internal(
          () => Qr()..orderHash = orderHash,
          from: qrProvider,
          name: r'qrProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$qrHash,
          dependencies: QrFamily._dependencies,
          allTransitiveDependencies: QrFamily._allTransitiveDependencies,
          orderHash: orderHash,
        );

  QrProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderHash,
  }) : super.internal();

  final String orderHash;

  @override
  QrState runNotifierBuild(
    covariant Qr notifier,
  ) {
    return notifier.build(
      orderHash,
    );
  }

  @override
  Override overrideWith(Qr Function() create) {
    return ProviderOverride(
      origin: this,
      override: QrProvider._internal(
        () => create()..orderHash = orderHash,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderHash: orderHash,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<Qr, QrState> createElement() {
    return _QrProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QrProvider && other.orderHash == orderHash;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderHash.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QrRef on AutoDisposeNotifierProviderRef<QrState> {
  /// The parameter `orderHash` of this provider.
  String get orderHash;
}

class _QrProviderElement extends AutoDisposeNotifierProviderElement<Qr, QrState>
    with QrRef {
  _QrProviderElement(super.provider);

  @override
  String get orderHash => (origin as QrProvider).orderHash;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
