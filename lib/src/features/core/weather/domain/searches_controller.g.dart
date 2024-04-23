// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searches_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchesHash() => r'f7f114aa30826bc802ecb69b99822b2ee5e46f96';

/// See also [searches].
@ProviderFor(searches)
final searchesProvider = StreamProvider<List<SearchModel>>.internal(
  searches,
  name: r'searchesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SearchesRef = StreamProviderRef<List<SearchModel>>;
String _$searchesControllerHash() =>
    r'18ed5eca276a59e5a4f0cbfbebc7ef185492ff49';

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
