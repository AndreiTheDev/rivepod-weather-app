// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherIconHash() => r'f31986d8d1ec6bbeaf5f941d066aa2438eacd901';

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

/// See also [weatherIcon].
@ProviderFor(weatherIcon)
const weatherIconProvider = WeatherIconFamily();

/// See also [weatherIcon].
class WeatherIconFamily extends Family<String> {
  /// See also [weatherIcon].
  const WeatherIconFamily();

  /// See also [weatherIcon].
  WeatherIconProvider call(
    int iconCode,
  ) {
    return WeatherIconProvider(
      iconCode,
    );
  }

  @override
  WeatherIconProvider getProviderOverride(
    covariant WeatherIconProvider provider,
  ) {
    return call(
      provider.iconCode,
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
  String? get name => r'weatherIconProvider';
}

/// See also [weatherIcon].
class WeatherIconProvider extends AutoDisposeProvider<String> {
  /// See also [weatherIcon].
  WeatherIconProvider(
    int iconCode,
  ) : this._internal(
          (ref) => weatherIcon(
            ref as WeatherIconRef,
            iconCode,
          ),
          from: weatherIconProvider,
          name: r'weatherIconProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weatherIconHash,
          dependencies: WeatherIconFamily._dependencies,
          allTransitiveDependencies:
              WeatherIconFamily._allTransitiveDependencies,
          iconCode: iconCode,
        );

  WeatherIconProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.iconCode,
  }) : super.internal();

  final int iconCode;

  @override
  Override overrideWith(
    String Function(WeatherIconRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeatherIconProvider._internal(
        (ref) => create(ref as WeatherIconRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        iconCode: iconCode,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _WeatherIconProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeatherIconProvider && other.iconCode == iconCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, iconCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WeatherIconRef on AutoDisposeProviderRef<String> {
  /// The parameter `iconCode` of this provider.
  int get iconCode;
}

class _WeatherIconProviderElement extends AutoDisposeProviderElement<String>
    with WeatherIconRef {
  _WeatherIconProviderElement(super.provider);

  @override
  int get iconCode => (origin as WeatherIconProvider).iconCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
