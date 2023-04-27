import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/inbox/view_models/message_view_model.dart';
import 'package:tiktokapp/utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({
    Key? key,
    required this.chatId,
  }) : super(key: key);

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _editingController = TextEditingController();

  void _onDismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onSendPress() {
    final text = _editingController.text;
    if (text == "") return;
    ref.read(messagesProvider.notifier).sendMessage(text);
    _editingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final isLoading = ref.watch(messagesProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: 22,
                foregroundImage: NetworkImage(
                    "https://lh3.googleusercontent.com/a/AGNmyxYol5lNtQShTuXHxFwtUaHFG7SJ7NgONKeSCEz9jg=s96-c-rg-br100"),
                child: Text("JS"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: Sizes.size18,
                  height: Sizes.size18,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(Sizes.size20),
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size3,
                    ),
                  ),
                ),
              )
            ],
          ),
          title: Text(
            "Camel (${widget.chatId})",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Theme.of(context).iconTheme.color,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Theme.of(context).iconTheme.color,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _onDismissKeyboard,
        child: Stack(
          children: [
            ref.watch(chatProvider).when(
                  data: (data) {
                    return ListView.separated(
                      reverse: true,
                      padding: EdgeInsets.only(
                        top: Sizes.size20,
                        bottom: MediaQuery.of(context).padding.bottom +
                            Sizes.size96,
                        left: Sizes.size14,
                        right: Sizes.size14,
                      ),
                      itemBuilder: (context, index) {
                        final message = data[index];
                        final isMine =
                            message.userId == ref.watch(authRepo).user!.uid;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: isMine
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(Sizes.size14),
                              decoration: BoxDecoration(
                                color: isMine
                                    ? Colors.blue
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(Sizes.size20),
                                  topRight: const Radius.circular(Sizes.size20),
                                  bottomLeft: Radius.circular(
                                      isMine ? Sizes.size20 : Sizes.size5),
                                  bottomRight: Radius.circular(
                                      !isMine ? Sizes.size20 : Sizes.size5),
                                ),
                              ),
                              child: Text(
                                message.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemCount: data.length,
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                  vertical: Sizes.size24,
                ),
                color: isDark
                    ? Theme.of(context).appBarTheme.backgroundColor
                    : Colors.grey.shade50,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Sizes.size44,
                        child: TextField(
                          controller: _editingController,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          textInputAction: TextInputAction.newline,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: "Add comment...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.size12,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.faceSmile,
                                  color: isDark
                                      ? Colors.grey.shade200
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h14,
                    GestureDetector(
                      onTap: isLoading ? null : _onSendPress,
                      child: Container(
                        padding: const EdgeInsets.all(Sizes.size10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade100,
                        ),
                        child: Center(
                          child: FaIcon(
                            isLoading
                                ? FontAwesomeIcons.hourglass
                                : FontAwesomeIcons.paperPlane,
                            size: Sizes.size20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
