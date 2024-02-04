// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_scroll_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$forecastScrollControllerHash() =>
    r'b03552b4f29e3bb9009add6a47149b9233377c3f';

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

/// See also [forecastScrollController].
@ProviderFor(forecastScrollController)
const forecastScrollControllerProvider = ForecastScrollControllerFamily();

/// See also [forecastScrollController].
class ForecastScrollControllerFamily extends Family<ForecastScrollContainer> {
  /// See also [forecastScrollController].
  const ForecastScrollControllerFamily();

  /// See also [forecastScrollController].
  ForecastScrollControllerProvider call(
    ScrollController controller,
    double offset,
    int listLength,
  ) {
    return ForecastScrollControllerProvider(
      controller,
      offset,
      listLength,
    );
  }

  @override
  ForecastScrollControllerProvider getProviderOverride(
    covariant ForecastScrollControllerProvider provider,
  ) {
    return call(
      provider.controller,
      provider.offset,
      provider.listLength,
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
  String? get name => r'forecastScrollControllerProvider';
}

/// See also [forecastScrollController].
class ForecastScrollControllerProvider
    extends AutoDisposeProvider<ForecastScrollContainer> {
  /// See also [forecastScrollController].
  ForecastScrollControllerProvider(
    ScrollController controller,
    double offset,
    int listLength,
  ) : this._internal(
          (ref) => forecastScrollController(
            ref as ForecastScrollControllerRef,
            controller,
            offset,
            listLength,
          ),
          from: forecastScrollControllerProvider,
          name: r'forecastScrollControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$forecastScrollControllerHash,
          dependencies: ForecastScrollControllerFamily._dependencies,
          allTransitiveDependencies:
              ForecastScrollControllerFamily._allTransitiveDependencies,
          controller: controller,
          offset: offset,
          listLength: listLength,
        );

  ForecastScrollControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.controller,
    required this.offset,
    required this.listLength,
  }) : super.internal();

  final ScrollController controller;
  final double offset;
  final int listLength;

  @override
  Override overrideWith(
    ForecastScrollContainer Function(ForecastScrollControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ForecastScrollControllerProvider._internal(
        (ref) => create(ref as ForecastScrollControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        controller: controller,
        offset: offset,
        listLength: listLength,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ForecastScrollContainer> createElement() {
    return _ForecastScrollControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ForecastScrollControllerProvider &&
        other.controller == controller &&
        other.offset == offset &&
        other.listLength == listLength;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, controller.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, listLength.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ForecastScrollControllerRef
    on AutoDisposeProviderRef<ForecastScrollContainer> {
  /// The parameter `controller` of this provider.
  ScrollController get controller;

  /// The parameter `offset` of this provider.
  double get offset;

  /// The parameter `listLength` of this provider.
  int get listLength;
}

class _ForecastScrollControllerProviderElement
    extends AutoDisposeProviderElement<ForecastScrollContainer>
    with ForecastScrollControllerRef {
  _ForecastScrollControllerProviderElement(super.provider);

  @override
  ScrollController get controller =>
      (origin as ForecastScrollControllerProvider).controller;
  @override
  double get offset => (origin as ForecastScrollControllerProvider).offset;
  @override
  int get listLength => (origin as ForecastScrollControllerProvider).listLength;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
