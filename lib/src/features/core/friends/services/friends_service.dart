// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../authentication/domain/auth_controller.dart';
import '../../error_handling/app_exceptions/app_exception.dart';
import '../../error_handling/app_exceptions/error_types.dart';
import '../../error_handling/logger.dart';
import '../data/friends_repository.dart';
import '../domain/models/friend.dart';

part 'friends_service.g.dart';

@Riverpod(keepAlive: true)
FriendsService friendsService(final FriendsServiceRef ref) => FriendsService(
      ref.watch(authStateProvider),
      ref.watch(friendsRepositoryProvider),
    );

class FriendsService {
  FriendsService(this._authState, this._friendsRepository);

  final AuthState _authState;
  final FriendsRepository _friendsRepository;
  final Logger _logger = getLogger(FriendsService);

  Future<Result<void, AppException>> addFriend(final Friend friend) async {
    try {
      await _friendsRepository.addFriend(
        _authState.user!,
        friend.toEntity(),
      );
      return const Success(null);
    } on FirebaseException catch (e) {
      _logger
        ..e('addFriend - ${e.code}')
        ..e('addFriend - ${e.message}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('addFriend - $unknownErrorCode');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Future<Result<void, AppException>> deleteFriend(final Friend friend) async {
    try {
      await _friendsRepository.deleteFriend(
        _authState.user!,
        friend.toEntity(),
      );
      return const Success(null);
    } on FirebaseException catch (e) {
      _logger.e('deleteFriend - ${e.code}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('deleteFriend - $unknownErrorCode');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Future<Result<void, AppException>> acceptFriend(final Friend friend) async {
    try {
      await _friendsRepository.acceptFriend(
        _authState.user!,
        friend.toEntity(),
      );
      return const Success(null);
    } on FirebaseException catch (e) {
      _logger.e('acceptFriend - ${e.code}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('acceptFriend - $unknownErrorCode');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Future<Result<void, AppException>> rejectFriend(final Friend friend) async {
    try {
      await _friendsRepository.rejectFriend(
        _authState.user!,
        friend.toEntity(),
      );
      return const Success(null);
    } on FirebaseException catch (e) {
      _logger.e('rejectFriend - ${e.code}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('rejectFriend - $unknownErrorCode');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Future<Result<bool, AppException>> isAlreadyFriend(
    final String friendUid,
  ) async {
    try {
      final bool isFriend = await _friendsRepository.isAlreadyFriend(
        _authState.user!.uid,
        friendUid,
      );
      return Success(isFriend);
    } on FirebaseException catch (e) {
      _logger.e('isAlreadyFriend - ${e.code}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('isAlreadyFriend - $unknownErrorCode');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Future<Result<bool, AppException>> hasFriendRequest(
    final String friendUid,
  ) async {
    try {
      final bool hasFriendRequest = await _friendsRepository.hasFriendRequest(
        _authState.user!.uid,
        friendUid,
      );
      return Success(hasFriendRequest);
    } on FirebaseException catch (e) {
      _logger.e('hasFriendRequest - ${e.code}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('hasFriendRequest - $unknownErrorCode');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendsStream() {
    if (_authState.user != null) {
      return _friendsRepository.getFriends(_authState.user!.uid);
    }
    return null;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getFriendRequestStream() {
    if (_authState.user != null) {
      return _friendsRepository.getFriendsRequests(_authState.user!.uid);
    }
    return null;
  }
}
