// ignore_for_file: always_specify_types

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error_handling/snackbar_controller.dart';

class FieldItemState {
  FieldItemState({this.fieldText, this.errorText});

  final String? fieldText;
  final String? errorText;

  FieldItemState copyWith({final String? fieldText, final String? errorText}) {
    return FieldItemState(
      fieldText: fieldText ?? this.fieldText,
      errorText: errorText,
    );
  }
}

final emailControllerProvider =
    StateNotifierProvider<EmailController, FieldItemState>(
  (final ref) => EmailController(),
);

class EmailController extends StateNotifier<FieldItemState> {
  EmailController() : super(FieldItemState());

  final RegExp _emailRegex = RegExp(
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
  );

  void onEmailChange(final String value) {
    if (_emailRegex.hasMatch(value)) {
      state = state.copyWith(
        fieldText: value,
      );
    } else {
      state = state.copyWith(fieldText: value, errorText: 'Invalid email');
    }
    print(state.fieldText);
  }
}

final passwordControllerProvider =
    StateNotifierProvider<PasswordController, FieldItemState>(
  (final ref) => PasswordController(),
);

class PasswordController extends StateNotifier<FieldItemState> {
  PasswordController() : super(FieldItemState());

  final RegExp _passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  void onPasswordChange(final String value) {
    if (_passwordRegex.hasMatch(value)) {
      state = state.copyWith(fieldText: value);
    } else {
      state = state.copyWith(fieldText: value, errorText: 'Invalid password');
    }
    print(state.fieldText);
  }
}

final usernameControllerProvider =
    StateNotifierProvider<UsernameController, FieldItemState>(
  (final ref) => UsernameController(),
);

class UsernameController extends StateNotifier<FieldItemState> {
  UsernameController() : super(FieldItemState());

  void onUsernameChange(final String value) {
    if (value.length > 6) {
      state = state.copyWith(fieldText: value);
    } else {
      state = state.copyWith(fieldText: value, errorText: 'Invalid username');
    }
    print(state.fieldText);
  }
}

final signInProvider = Provider<SignInProvider>(
  (final ref) {
    return SignInProvider(
      emailField: ref.watch(emailControllerProvider),
      passwordField: ref.watch(passwordControllerProvider),
      snackbarController: ref.read(snackbarControllerProvider.notifier),
    );
  },
);

class SignInProvider {
  SignInProvider({
    required this.emailField,
    required this.passwordField,
    required this.snackbarController,
  });

  final FieldItemState emailField;
  final FieldItemState passwordField;
  final SnackbarController snackbarController;

  bool validate() {
    if (emailField.errorText == null &&
        emailField.fieldText != null &&
        passwordField.errorText == null &&
        passwordField.fieldText != null) {
      return true;
    }
    snackbarController.setMessage(
      'Complete all fields',
      SnackbarType.error,
    );
    return false;
  }
}

final signUpProvider = Provider<SignUpProvider>(
  (final ref) {
    return SignUpProvider(
      usernameField: ref.watch(usernameControllerProvider),
      emailField: ref.watch(emailControllerProvider),
      passwordField: ref.watch(passwordControllerProvider),
      snackbarController: ref.read(snackbarControllerProvider.notifier),
    );
  },
);

class SignUpProvider {
  SignUpProvider({
    required this.usernameField,
    required this.emailField,
    required this.passwordField,
    required this.snackbarController,
  });

  final FieldItemState usernameField;
  final FieldItemState emailField;
  final FieldItemState passwordField;
  final SnackbarController snackbarController;

  bool validate() {
    if (usernameField.errorText == null &&
        usernameField.fieldText != null &&
        emailField.errorText == null &&
        emailField.fieldText != null &&
        passwordField.errorText == null &&
        passwordField.fieldText != null) {
      return true;
    }
    snackbarController.setMessage(
      'Complete all fields',
      SnackbarType.error,
    );
    return false;
  }
}
