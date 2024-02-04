import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/core/friends/domain/friends_controller.dart';
import '../features/core/friends/domain/models/friend.dart';
import '../features/core/weather/domain/models/search.dart';
import 'colors.dart' as colors;

Future<void> showFriendDialog(
  final BuildContext context,
  final SearchModel searchModel, {
  required final bool isFriend,
}) async {
  await showDialog(
    context: context,
    builder: (final context) {
      return Dialog(
        backgroundColor: colors.primaryColor,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          width: MediaQuery.of(context).size.width - 64,
          child: Column(
            children: [
              Expanded(
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    const Icon(
                      Icons.person,
                      color: colors.detailColor,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      searchModel.username,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: context.pop,
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Consumer(
                    builder: (final context, final ref, final child) =>
                        Expanded(
                      child: ElevatedButton(
                        onPressed: isFriend
                            ? null
                            : () async {
                                await ref
                                    .read(friendsControllerProvider)
                                    .addFriend(
                                      Friend(
                                        email: searchModel.email,
                                        uid: searchModel.uid,
                                        username: searchModel.username,
                                      ),
                                    );
                                if (context.mounted) {
                                  context.pop();
                                }
                              },
                        child: const Text('Add Friend'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showConfirmationDialog(
  final BuildContext context,
  final String message,
  final Friend friendModel,
) async {
  await showDialog(
    context: context,
    builder: (final context) {
      return Dialog(
        backgroundColor: colors.primaryColor,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 200,
          width: MediaQuery.of(context).size.width - 64,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: context.pop,
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Consumer(
                    builder: (final context, final ref, final child) =>
                        Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(friendsControllerProvider)
                              .deleteFriend(friendModel);
                          if (context.mounted) {
                            context.pop();
                          }
                        },
                        child: const Text('Delete'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
