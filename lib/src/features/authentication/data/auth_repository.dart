// ignore_for_file: always_specify_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/error_handling/app_exceptions/app_exception.dart';
import '../../core/error_handling/app_exceptions/error_types.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(final AuthRepositoryRef ref) => AuthRepository();

class AuthRepository {
  AuthRepository();

  final FirebaseAuth _instance = FirebaseAuth.instance;

  Future<User> signInWithEmail(
    final String email,
    final String password,
  ) async {
    final userCredential = await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      return userCredential.user!;
    }
    throw AppException.getFirebaseException(
      noUserDataCode,
    );
  }

  Future<User> signUpWithEmail(
    final String email,
    final String password,
  ) async {
    final userCredential = await _instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      return userCredential.user!;
    }
    throw AppException.getFirebaseException(
      noUserDataCode,
    );
  }

  Future<void> signOut() async {
    await _instance.signOut();
  }

  Future<void> deleteUser() async {
    if (_instance.currentUser != null) {
      await _instance.currentUser!.delete();
    }
  }

  Future<void> recoverPassword(final String email) async {
    await _instance.sendPasswordResetEmail(email: email);
  }

  User? isLoggedIn() {
    return _instance.currentUser;
  }
}
