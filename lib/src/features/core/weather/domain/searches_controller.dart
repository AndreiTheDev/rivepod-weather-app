import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error_handling/snackbar_controller.dart';
import '../services/weather_service.dart';
import 'models/search.dart';

part 'searches_controller.g.dart';

@Riverpod(keepAlive: true)
Stream<(List<SearchModel>, DocumentSnapshot)> searches(
  final SearchesRef ref,
) async* {
  final stream = ref.watch(weatherServiceProvider).getSearchesStream();

  var allSearches = const <SearchModel>[];
  await for (final snapshot in stream) {
    allSearches = snapshot.docs
        .map((final element) => SearchModel.fromData(element.data()))
        .toList();
    yield (allSearches, snapshot.docs.last);
  }
}

class SearchesState {
  final List<SearchModel> searchesList;
  final DocumentSnapshot? lastDoc;

  SearchesState({required this.searchesList, this.lastDoc});

  SearchesState copyWith(
    final List<SearchModel>? searchesList,
    final DocumentSnapshot? lastDoc,
  ) {
    return SearchesState(
      searchesList: searchesList ?? this.searchesList,
      lastDoc: lastDoc ?? this.lastDoc,
    );
  }
}

@Riverpod(keepAlive: true)
class SearchesController extends _$SearchesController {
  @override
  Future<SearchesState> build() async {
    final searchesStreamRecord = await ref.watch(searchesProvider.future);
    final List<SearchModel> newSearchesList = searchesStreamRecord.$1;
    DocumentSnapshot? lastDoc = searchesStreamRecord.$2;
    final prevState = state.valueOrNull;

    if (prevState == null) {
      return SearchesState(
        searchesList: newSearchesList,
        lastDoc: lastDoc,
      );
    }

    final updatedSearchesList = prevState.searchesList;
    lastDoc = prevState.lastDoc;
    for (final element in newSearchesList.reversed) {
      if (!updatedSearchesList.contains(element)) {
        updatedSearchesList.insert(0, element);
      }
    }

    return SearchesState(
      searchesList: updatedSearchesList,
      lastDoc: lastDoc,
    );
  }

  Future<void> fetchNextSearches() async {
    final prevState = state.valueOrNull;
    if (prevState == null || prevState.lastDoc == null) {
      return;
    }
    final response = await ref
        .read(weatherServiceProvider)
        .fetchNextSearches(prevState.lastDoc!);
    final updatedSearchesList = prevState.searchesList;
    DocumentSnapshot? lastDoc;
    response.when((final success) {
      lastDoc = success.isNotEmpty ? success.last : null;
      for (final element in success) {
        updatedSearchesList.add(SearchModel.fromData(element.data()));
      }
    }, (final error) {
      ref
          .read(snackbarControllerProvider.notifier)
          .setMessage(error.message, SnackbarType.error);
    });
    state = AsyncData(
      SearchesState(searchesList: updatedSearchesList, lastDoc: lastDoc),
    );
  }
}
