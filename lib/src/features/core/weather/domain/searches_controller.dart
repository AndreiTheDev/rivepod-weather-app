import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/weather_service.dart';
import 'models/search.dart';

part 'searches_controller.g.dart';

@Riverpod(keepAlive: true)
Stream<List<SearchModel>> searches(final SearchesRef ref) async* {
  final stream = ref.watch(weatherServiceProvider).getSearchesStream();

  var allSearches = const <SearchModel>[];
  await for (final snapshot in stream) {
    allSearches = snapshot.docs
        .map((final element) => SearchModel.fromData(element.data()))
        .toList();
    yield allSearches;
  }
}
