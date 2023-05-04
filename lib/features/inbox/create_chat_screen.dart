import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/features/inbox/view_models/chats_view_model.dart';
import 'package:tiktokapp/features/users/view_models/users_list_view_model.dart';
import 'package:tiktokapp/features/users/widgets/avatar.dart';

class CreateChatScreen extends ConsumerStatefulWidget {
  static const String routeName = "createChat";
  static const String routeURL = "/createChat";

  const CreateChatScreen({super.key});

  @override
  ConsumerState<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends ConsumerState<CreateChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Create Chat Room"),
      ),
      body: ref.watch(usersListProvider).when(
            data: (data) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final user = data[index];
                  return GestureDetector(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text("Sure to talk with ${user.name}?"),
                          content: Avatar(
                            uid: user.uid,
                            name: user.name,
                            hasAvatar: user.hasAvatar,
                            size: 20,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () => context.pop(),
                              isDefaultAction: true,
                              child: const Text("NO"),
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              isDestructiveAction: true,
                              onPressed: () async {
                                await ref
                                    .read(chatsProvider.notifier)
                                    .createChatRoom(user.uid, context);
                                if (mounted) {
                                  context.pop();
                                }
                              },
                              child: const Text("Yes"),
                            )
                          ],
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Avatar(
                        uid: user.uid,
                        name: user.name,
                        hasAvatar: user.hasAvatar,
                        size: 25,
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    ),
                    // child: Row(
                    //   children: [
                    //     Avatar(
                    //       uid: user.uid,
                    //       name: user.name,
                    //       hasAvatar: user.hasAvatar,
                    //       size: 25,
                    //     ),
                    //     Gaps.h20,
                    //     Text(user.name),
                    //   ],
                    // ),
                  );
                },
                separatorBuilder: (context, index) => Gaps.v5,
                itemCount: data.length,
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
    );
  }
}
