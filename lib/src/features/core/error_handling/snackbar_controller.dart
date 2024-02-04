// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/colors.dart' as colors;

part 'snackbar_controller.g.dart';

enum SnackbarType {
  success,
  error,
}

class SnackbarState {
  SnackbarState({required this.message, required this.type});

  final String message;
  final SnackbarType type;

  SnackbarState copyWith({final String? message, final SnackbarType? type}) {
    return SnackbarState(
      message: message ?? this.message,
      type: type ?? this.type,
    );
  }
}

@Riverpod(keepAlive: true)
class SnackbarController extends _$SnackbarController {
  @override
  SnackbarState build() {
    return SnackbarState(
      message: '',
      type: SnackbarType.error,
    );
  }

  void setMessage(final String message, final SnackbarType type) {
    state = state.copyWith(message: message, type: type);
  }
}

void snackbarDisplayer(final BuildContext context, final WidgetRef ref) {
  ref.listen(snackbarControllerProvider, (
    final SnackbarState? previous,
    final SnackbarState next,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(next.message),
        backgroundColor: next.type == SnackbarType.error
            ? colors.errorColor
            : colors.successColor,
      ),
    );
  });
}
