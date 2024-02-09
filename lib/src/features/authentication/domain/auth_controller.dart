// ignore: lines_longer_than_80_chars
// ignore_for_file: always_specify_types, avoid_manual_providers_as_generated_provider_dependency

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/error_handling/logger.dart';
import '../../core/error_handling/snackbar_controller.dart';
import '../services/auth_service.dart';
import 'form_controller.dart';
import 'models/user_model.dart';

part 'auth_controller.g.dart';

enum AuthUserState {
  signedIn,
  signedOut,
  unknown,
}

final authStateProvider = ChangeNotifierProvider(
  (final ref) => AuthState(authUserState: AuthUserState.unknown),
);

class AuthState with ChangeNotifier {
  AuthState({
    required this.authUserState,
    this.user,
  });

  UserModel? user;
  AuthUserState authUserState;
  final Logger logger = getLogger(AuthState);

  void setAuthState({
    required final AuthUserState state,
    final UserModel? user,
  }) {
    logger.d('setAuthState - updatedState - $state');
    this.user = user;
    authUserState = state;
    notifyListeners();
  }
}

@Riverpod(keepAlive: true)
AuthController authController(final AuthControllerRef ref) => AuthController(
      authState: ref.watch(authStateProvider),
      authService: ref.read(authServiceProvider),
      signInProvider: ref.watch(signInProvider),
      signUpProvider: ref.watch(signUpProvider),
      snackbarController: ref.read(snackbarControllerProvider.notifier),
    );

class AuthController {
  AuthController({
    required this.authState,
    required this.authService,
    required this.signInProvider,
    required this.signUpProvider,
    required this.snackbarController,
  });

  final AuthState authState;
  final AuthService authService;
  final SignIn signInProvider;
  final SignUp signUpProvider;
  final SnackbarController snackbarController;
  final Logger logger = getLogger(AuthController);

  Future<void> signInUser() async {
    logger.d('signInUser - call');
    if (signInProvider.validate()) {
      final String email = signInProvider.emailField.fieldText!;
      final String password = signInProvider.passwordField.fieldText!;
      final response = await authService.signInUser(email, password);
      response.when(
        (final success) {
          authState.setAuthState(
            user: UserModel.fromEntity(success),
            state: AuthUserState.signedIn,
          );
        },
        (final error) =>
            snackbarController.setMessage(error.message, SnackbarType.error),
      );
    }
  }

  Future<void> signUpUser() async {
    logger.d('signUpUser - call');
    if (signUpProvider.validate()) {
      final String email = signUpProvider.emailField.fieldText!;
      final String password = signUpProvider.passwordField.fieldText!;
      final String username =
          signUpProvider.usernameField.fieldText!.toLowerCase();

      final response = await authService.signUpUser(email, password, username);
      response.when(
        (final success) {
          authState.setAuthState(
            user: UserModel.fromEntity(success),
            state: AuthUserState.signedIn,
          );
        },
        (final error) =>
            snackbarController.setMessage(error.message, SnackbarType.error),
      );
    }
  }

  Future<void> signOutUser() async {
    logger.d('signOutUser - call');
    final response = await authService.signOutUser();
    response.when(
      (final success) {
        authState.setAuthState(state: AuthUserState.signedOut);
      },
      (final error) =>
          snackbarController.setMessage(error.message, SnackbarType.error),
    );
  }

  Future<bool> recoverPassword(final String email) async {
    final response = await authService.recoverPassword(email);
    final bool isSuccess =
        response.when((final success) => true, (final error) {
      snackbarController.setMessage(error.message, SnackbarType.error);
      return false;
    });
    return isSuccess;
  }

  Future<void> initState() async {
    logger.d('initState - call');
    final response = await authService.checkUserLoggedIn();
    response.when(
      (final success) {
        if (success == null) {
          authState.setAuthState(state: AuthUserState.signedOut);
        } else {
          authState.setAuthState(
            user: UserModel.fromEntity(success),
            state: AuthUserState.signedIn,
          );
        }
      },
      (final error) =>
          snackbarController.setMessage(error.message, SnackbarType.error),
    );
  }
}
