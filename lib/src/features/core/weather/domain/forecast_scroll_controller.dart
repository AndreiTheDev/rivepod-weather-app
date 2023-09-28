import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../error_handling/logger.dart';

final AutoDisposeProviderFamily<ForecastScrollContainer, Map<String, dynamic>>
    forecastScrollController = Provider.autoDispose.family(
  (
    final AutoDisposeProviderRef<Object?> ref,
    final Map<String, dynamic> family,
  ) =>
      ForecastScrollContainer(
    family['scrollController'],
    family['offset'],
    family['listLength'],
  ),
);

class ForecastScrollContainer {
  ForecastScrollContainer(this.scrollController, this.offset, this.listLenght);

  final Logger _logger = getLogger(ForecastScrollContainer);
  int _currentIndex = 0;
  final double offset;
  final ScrollController scrollController;
  final int listLenght;

  Future<void> onScreenDrag(final DragEndDetails details) async {
    _logger.d('dragging ForecastContainer');
    bool indexChanged = false;
    if (details.primaryVelocity! < 0 && _currentIndex < listLenght) {
      _currentIndex++;
      indexChanged = true;
    }
    if (details.primaryVelocity! > 0 && _currentIndex > 0) {
      _currentIndex--;
      indexChanged = true;
    }
    if (indexChanged) {
      await scrollController.animateTo(
        offset * _currentIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
    }
  }
}
