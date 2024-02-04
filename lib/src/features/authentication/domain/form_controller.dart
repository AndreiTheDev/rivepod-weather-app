// ignore_for_file: always_specify_types

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/error_handling/snackbar_controller.dart';

part 'form_controller.g.dart';

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

@Riverpod(keepAlive: true)
class EmailController extends _$EmailController {
  @override
  FieldItemState build() {
    return FieldItemState();
  }

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
  }
}

@Riverpod(keepAlive: true)
class PasswordController extends _$PasswordController {
  @override
  FieldItemState build() {
    return FieldItemState();
  }

  final RegExp _passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  void onPasswordChange(final String value) {
    if (_passwordRegex.hasMatch(value)) {
      state = state.copyWith(fieldText: value);
    } else {
      state = state.copyWith(fieldText: value, errorText: 'Invalid password');
    }
  }
}

@Riverpod(keepAlive: true)
class UsernameController extends _$UsernameController {
  @override
  FieldItemState build() {
    return FieldItemState();
  }

  void onUsernameChange(final String value) {
    if (value.length > 6) {
      state = state.copyWith(fieldText: value);
    } else {
      state = state.copyWith(fieldText: value, errorText: 'Invalid username');
    }
  }
}

@Riverpod(keepAlive: true)
SignIn signIn(final SignInRef ref) => SignIn(
      emailField: ref.watch(emailControllerProvider),
      passwordField: ref.watch(passwordControllerProvider),
      snackbarController: ref.read(snackbarControllerProvider.notifier),
    );

class SignIn {
  SignIn({
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

@Riverpod(keepAlive: true)
SignUp signUp(final SignUpRef ref) => SignUp(
      usernameField: ref.watch(usernameControllerProvider),
      emailField: ref.watch(emailControllerProvider),
      passwordField: ref.watch(passwordControllerProvider),
      snackbarController: ref.read(snackbarControllerProvider.notifier),
    );

class SignUp {
  SignUp({
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
