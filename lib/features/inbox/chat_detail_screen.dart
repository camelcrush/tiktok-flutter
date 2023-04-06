import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  void _onDismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

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
          title: const Text(
            "Camel",
            style: TextStyle(
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
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                      child: const Text(
                        "This is a message!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10,
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
                    Container(
                      padding: const EdgeInsets.all(Sizes.size10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade100,
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.paperPlane,
                          size: Sizes.size20,
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
