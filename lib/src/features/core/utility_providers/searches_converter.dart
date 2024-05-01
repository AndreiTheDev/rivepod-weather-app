import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../settings/domain/user_prefs_controller.dart';
import '../weather/domain/models/search.dart';
import '../weather/domain/searches_controller.dart';

part 'searches_converter.g.dart';

@Riverpod(keepAlive: true)
AsyncValue<List<SearchModel>> convertedSearches(
  final ConvertedSearchesRef ref,
) {
  final searchesController = ref.watch(searchesControllerProvider);
  final userUnitsPrefs = ref.watch(
    userPrefsControllerProvider.select((final state) => state.metricUnits),
  );

  final AsyncValue<List<SearchModel>> convertedSearches =
      searchesController.when(
    data: (final searchesState) {
      final searchesModels = searchesState.searchesList.map((final search) {
        if (userUnitsPrefs == search.isMetricUnits) {
          return search;
        }
        if (userUnitsPrefs) {
          final celsiusTemp = (int.parse(search.temp) - 32) * (5 / 9);
          return search.copyWith(
            isMetricUnits: userUnitsPrefs,
            temp: celsiusTemp.toStringAsFixed(0),
          );
        }
        if (!userUnitsPrefs) {
          final fahrenheitTemp = (int.parse(search.temp) * (9 / 5)) + 32;
          return search.copyWith(
            isMetricUnits: userUnitsPrefs,
            temp: fahrenheitTemp.toStringAsFixed(0),
          );
        }
        return search;
      }).toList();
      return AsyncData(searchesModels);
    },
    error: (final error, final stack) {
      return AsyncError(error, stack);
    },
    loading: AsyncLoading.new,
  );
  return convertedSearches;
}
