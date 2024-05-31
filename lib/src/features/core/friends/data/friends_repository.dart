import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../utils/constants.dart';
import '../../../authentication/domain/models/user_model.dart';
import 'entities/friend_entity.dart';

part 'friends_repository.g.dart';

@Riverpod(keepAlive: true)
FriendsRepository friendsRepository(final FriendsRepositoryRef ref) =>
    FriendsRepository();

class FriendsRepository {
  FriendsRepository();

  final FirebaseFunctions _functionsInstance = FirebaseFunctions.instance;
  final FirebaseFirestore _dbInstance = FirebaseFirestore.instance;

  Future<void> addFriend(
    final UserModel currUser,
    final FriendEntity friendEntity,
  ) async {
    if (await isAlreadyFriend(currUser.uid, friendEntity.uid)) {
      return;
    }
    if (currUser.uid != friendEntity.uid) {
      if (await hasFriendRequest(currUser.uid, friendEntity.uid)) {
        await acceptFriend(currUser, friendEntity);
        return;
      }
      await _functionsInstance.httpsCallableFromUrl(kAddFriendUrl).call(
        {
          'currentUser': currUser.toDatabase(),
          'friend': friendEntity.toDatabase(),
        },
      );
    }
  }

  Future<void> deleteFriend(
    final UserModel currUser,
    final FriendEntity friendEntity,
  ) async {
    if (currUser.uid != friendEntity.uid) {
      if (await hasFriendRequest(currUser.uid, friendEntity.uid)) {
        return;
      }
      await _functionsInstance.httpsCallableFromUrl(kDeleteFriendUrl).call({
        'currentUser': currUser.toDatabase(),
        'friend': friendEntity.toDatabase(),
      });
    }
  }

  Future<void> acceptFriend(
    final UserModel currUser,
    final FriendEntity friendEntity,
  ) async {
    if (currUser.uid != friendEntity.uid) {
      final WriteBatch batch = _dbInstance.batch()
        ..set(
          _dbInstance
              .collection('users')
              .doc(currUser.uid)
              .collection('user_friends')
              .doc(friendEntity.uid),
          friendEntity.toDatabase(),
        )
        ..delete(
          _dbInstance
              .collection('users')
              .doc(currUser.uid)
              .collection('user_friends_requests')
              .doc(friendEntity.uid),
        );
      await batch.commit();
    }
  }

  Future<void> rejectFriend(
    final UserModel currUser,
    final FriendEntity friendEntity,
  ) async {
    if (currUser.uid != friendEntity.uid) {
      await _functionsInstance.httpsCallableFromUrl(kRejectFriendUrl).call({
        'currentUser': currUser.toDatabase(),
        'friend': friendEntity.toDatabase(),
      });
    }
  }

  Future<bool> isAlreadyFriend(
    final String currUid,
    final String friendUid,
  ) async {
    if (currUid == friendUid) {
      return true;
    }
    final friendDoc = await _dbInstance
        .collection('users')
        .doc(currUid)
        .collection('user_friends')
        .doc(friendUid)
        .get();
    return friendDoc.exists;
  }

  Future<bool> hasFriendRequest(
    final String currUid,
    final String friendUid,
  ) async {
    final friendRequest = await _dbInstance
        .collection('users')
        .doc(currUid)
        .collection('user_friends_requests')
        .doc(friendUid)
        .get();
    return friendRequest.exists;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFriends(final String uid) {
    return _dbInstance
        .collection('users')
        .doc(uid)
        .collection('user_friends')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFriendsRequests(
    final String uid,
  ) {
    return _dbInstance
        .collection('users')
        .doc(uid)
        .collection('user_friends_requests')
        .snapshots();
  }
}
