import 'package:cloud_firestore/cloud_firestore.dart';
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

class SearchesState {
  final List<SearchModel> searchesList;
  DocumentSnapshot? lastDocument;

  SearchesState({required this.searchesList, this.lastDocument});

  SearchesState copyWith(
    final List<SearchModel>? searchesList,
    final DocumentSnapshot? lastDocument,
  ) {
    return SearchesState(
      searchesList: searchesList ?? this.searchesList,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }
}

@Riverpod(keepAlive: true)
class SearchesController extends _$SearchesController {
  @override
  Future<SearchesState> build() async {
    final searchesStreamData = await ref.watch(searchesProvider.future);
    final List<SearchModel> allSearches = <SearchModel>[];
    DocumentSnapshot? lastDoc;
    searchesStreamData.map(allSearches.add);
    final prevState = state.valueOrNull;
    if (prevState == null) {
      return SearchesState(
        searchesList: searchesStreamData,
        lastDocument: lastDoc,
      );
    }
    final newList = prevState.searchesList;
    for (final element in searchesStreamData.reversed) {
      if (!newList.contains(element)) {
        newList.insert(0, element);
      }
    }
    return SearchesState(
      searchesList: newList,
    );
  }
}
