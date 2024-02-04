import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error_handling/logger.dart';
import '../../error_handling/snackbar_controller.dart';
import '../data/entities/friend_entity.dart';
import '../services/friends_service.dart';
import 'models/friend.dart';

part 'friends_controller.g.dart';

@Riverpod(keepAlive: true)
FriendsController friendsController(final FriendsControllerRef ref) =>
    FriendsController(
      ref.watch(friendsServiceProvider),
      ref.read(snackbarControllerProvider.notifier),
    );

class FriendsController {
  FriendsController(this._service, this._snackbarController);

  final FriendsService _service;
  final SnackbarController _snackbarController;
  final Logger _logger = getLogger(FriendsController);

  Future<void> addFriend(final Friend friend) async {
    _logger.d('addFriend - call');
    final response = await _service.addFriend(friend);

    response.when(
      (final success) => null,
      (final error) =>
          _snackbarController.setMessage(error.message, SnackbarType.error),
    );
  }

  Future<void> deleteFriend(final Friend friend) async {
    _logger.d('deleteFriend - call');
    final response = await _service.deleteFriend(friend);

    response.when(
      (final success) => null,
      (final error) =>
          _snackbarController.setMessage(error.message, SnackbarType.error),
    );
  }

  Future<bool> checkIsFriendOrHasRequest(final String userUid) async {
    _logger.d('checkIsFriendOrHasRequest - call');
    final responseIsFriend = await _service.isAlreadyFriend(userUid);
    final responseHasRequest = await _service.hasFriendRequest(userUid);

    final resultIsFriend =
        responseIsFriend.when((final success) => success, (final error) {
      _snackbarController.setMessage(error.message, SnackbarType.error);
      return false;
    });
    final resultHasRequest =
        responseHasRequest.when((final success) => success, (final error) {
      _snackbarController.setMessage(error.message, SnackbarType.error);
      return false;
    });
    if (resultIsFriend || resultHasRequest) {
      return true;
    }
    return false;
  }

  Future<void> acceptFriend(final Friend friend) async {
    _logger.d('acceptFriend - call');
    final response = await _service.acceptFriend(friend);
    response.when(
      (final success) => null,
      (final error) =>
          _snackbarController.setMessage(error.message, SnackbarType.error),
    );
  }

  Future<void> rejectFriend(final Friend friend) async {
    _logger.d('rejectFriend - call');
    final response = await _service.rejectFriend(friend);
    response.when(
      (final success) => null,
      (final error) =>
          _snackbarController.setMessage(error.message, SnackbarType.error),
    );
  }
}

@Riverpod(keepAlive: true)
Stream<List<Friend>> friendsList(final FriendsListRef ref) async* {
  getLogger(StreamProvider).d('friendsListProvider - call');
  final stream = ref.watch(friendsServiceProvider).getFriendsStream();

  if (stream != null) {
    await for (final list in stream) {
      yield list.docs.map((final element) {
        return Friend.fromEntity(FriendEntity.fromDatabase(element.data()));
      }).toList();
    }
  }
}

@Riverpod(keepAlive: true)
Stream<List<Friend>> friendsRequestList(
  final FriendsRequestListRef ref,
) async* {
  getLogger(StreamProvider).d('friendsRequestListProvider - call');
  final stream = ref.watch(friendsServiceProvider).getFriendRequestStream();

  if (stream != null) {
    await for (final list in stream) {
      yield list.docs.map((final element) {
        return Friend.fromEntity(FriendEntity.fromDatabase(element.data()));
      }).toList();
    }
  }
}
