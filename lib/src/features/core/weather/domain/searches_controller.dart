import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/weather_service.dart';
import 'models/search.dart';

final searchesProvider = StreamProvider((final ref) async* {
  final stream = ref.watch(weatherServiceProvider).getSearchesStream();

  var allSearches = const <SearchModel>[];
  await for (final snapshot in stream) {
    allSearches = snapshot.docs
        .map((final element) => SearchModel.fromData(element.data()))
        .toList();
    yield allSearches;
  }
});
