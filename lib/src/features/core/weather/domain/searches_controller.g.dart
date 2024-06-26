// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searches_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchesHash() => r'65638b6345b79aa14cfc1033a9151feded09338e';

/// See also [searches].
@ProviderFor(searches)
final searchesProvider =
    StreamProvider<(List<SearchModel>, DocumentSnapshot)>.internal(
  searches,
  name: r'searchesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchesRef = StreamProviderRef<(List<SearchModel>, DocumentSnapshot)>;
String _$searchesControllerHash() =>
    r'eaec3ba3d52681d47e658527242670b42c265193';

/// See also [SearchesController].
@ProviderFor(SearchesController)
final searchesControllerProvider =
    AsyncNotifierProvider<SearchesController, SearchesState>.internal(
  SearchesController.new,
  name: r'searchesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchesController = AsyncNotifier<SearchesState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
