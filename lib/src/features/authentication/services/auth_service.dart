import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../core/error_handling/app_exceptions/app_exception.dart';
import '../../core/error_handling/app_exceptions/error_types.dart';
import '../../core/error_handling/logger.dart';
import '../data/auth_repository.dart';
import '../data/entities/user_entity.dart';
import '../data/user_repository.dart';

final authServiceProvider = Provider<AuthService>(
  (final ref) => AuthService(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class AuthService {
  AuthService({
    required this.authRepository,
    required this.userRepository,
  });

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Logger _logger = getLogger(AuthService);

  Future<Result<UserEntity, AppException>> signInUser(
    final String email,
    final String password,
  ) async {
    try {
      final user = await authRepository.signInWithEmail(email, password);

      final UserEntity userEntity = await userRepository.getUser(user);

      return Success(userEntity);
    } on AppException catch (e) {
      _logger.e('signInUser - ${e.code} - ${e.message}');
      await authRepository.signOut();
      return Error(e);
    } on FirebaseException catch (e) {
      _logger.e('signInUser - ${e.code} - ${e.message}');
      await authRepository.signOut();
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('signInUser - Unknown error');
      return Error(
        AppException(
          code: unknownErrorCode,
          message: unknownErrorMessage,
        ),
      );
    }
  }

  Future<Result<UserEntity, AppException>> signUpUser(
    final String email,
    final String password,
    final String username,
  ) async {
    try {
      final user = await authRepository.signUpWithEmail(email, password);
      final UserEntity userEntity = UserEntity(
        user: user,
        uid: user.uid,
        favCity: '',
        email: email,
        username: username,
      );
      await userRepository.postUser(user.uid, userEntity);
      return Success(userEntity);
    } on AppException catch (e) {
      _logger.e('signUpUser - ${e.code} - ${e.message}');
      await authRepository.deleteUser();
      return Error(e);
    } on FirebaseException catch (e) {
      _logger.e('signUpUser - ${e.code} - ${e.message}');
      await authRepository.deleteUser();
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('signUpUser - Unknown error');
      return Error(
        AppException(
          code: unknownErrorCode,
          message: unknownErrorMessage,
        ),
      );
    }
  }

  Future<Result<void, AppException>> signOutUser() async {
    try {
      await authRepository.signOut();
      return const Success(null);
    } on FirebaseException catch (e) {
      _logger.e('signOutUser - ${e.code} - ${e.message}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('signOutUser - Unknown error');
      return Error(
        AppException(
          code: unknownErrorCode,
          message: unknownErrorMessage,
        ),
      );
    }
  }

  Future<Result<UserEntity?, AppException>> checkUserLoggedIn() async {
    try {
      final user = authRepository.isLoggedIn();
      if (user == null) {
        return const Success(null);
      }
      final UserEntity userEntity = await userRepository.getUser(user);

      return Success(userEntity);
    } on AppException catch (e) {
      _logger.e('checkUserLoggedIn - ${e.code} - ${e.message}');
      await authRepository.signOut();
      return Error(e);
    } on FirebaseException catch (e) {
      _logger.e('checkUserLoggedIn - ${e.code} - ${e.message}');
      await authRepository.signOut();
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('checkUserLoggedIn - Unknown error');
      return Error(
        AppException(
          code: unknownErrorCode,
          message: unknownErrorMessage,
        ),
      );
    }
  }
}
