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
      return FriendDialogWidget(
        isFriend: isFriend,
        searchModel: searchModel,
      );
    },
  );
}

class FriendDialogWidget extends StatefulWidget {
  const FriendDialogWidget({
    required this.isFriend,
    required this.searchModel,
    super.key,
  });

  final bool isFriend;
  final SearchModel searchModel;

  @override
  State<FriendDialogWidget> createState() => _FriendDialogWidgetState();
}

class _FriendDialogWidgetState extends State<FriendDialogWidget> {
  bool isAddingFriend = false;

  @override
  Widget build(final BuildContext context) {
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
                    widget.searchModel.username,
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
                  builder: (final context, final ref, final child) => Expanded(
                    child: ElevatedButton(
                      onPressed: widget.isFriend
                          ? null
                          : () async {
                              setState(() {
                                isAddingFriend = true;
                              });
                              await ref
                                  .read(friendsControllerProvider)
                                  .addFriend(
                                    Friend(
                                      email: widget.searchModel.email,
                                      uid: widget.searchModel.uid,
                                      username: widget.searchModel.username,
                                    ),
                                  );
                              if (context.mounted) {
                                context.pop();
                              }
                            },
                      child: isAddingFriend
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Add Friend'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showConfirmationDialog(
  final BuildContext context,
  final String message,
  final Friend friendModel,
) async {
  await showDialog(
    context: context,
    builder: (final context) {
      return ConfirmationDialogWidget(
        message: message,
        friendModel: friendModel,
      );
    },
  );
}

class ConfirmationDialogWidget extends StatefulWidget {
  const ConfirmationDialogWidget({
    required this.message,
    required this.friendModel,
    super.key,
  });

  final String message;
  final Friend friendModel;

  @override
  State<ConfirmationDialogWidget> createState() =>
      _ConfirmationDialogWidgetState();
}

class _ConfirmationDialogWidgetState extends State<ConfirmationDialogWidget> {
  bool isDeletingFriend = false;
  @override
  Widget build(final BuildContext context) {
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
                  widget.message,
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
                  builder: (final context, final ref, final child) => Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isDeletingFriend = true;
                        });
                        await ref
                            .read(friendsControllerProvider)
                            .deleteFriend(widget.friendModel);
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                      child: isDeletingFriend
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Delete'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
