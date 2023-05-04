import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/features/inbox/chat_detail_screen.dart';
import 'package:tiktokapp/features/inbox/create_chat_screen.dart';
import 'package:tiktokapp/features/inbox/view_models/chats_view_model.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";

  const ChatsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  // StatefulWidget에서 각 위젯들을 구분짓기 위해서는 key가 필요하고 여기서는 GlobalKey를 설정
  // Key를 통해 해당 위젯의 state에 접근할 수 있음
  // final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  // final List<int> _items = [];

  // final Duration _duration = const Duration(milliseconds: 300);

  void _onCreateChat() {
    context.pushNamed(CreateChatScreen.routeName);
    // AnimatedList에서 initialItemCount = 0으로 초기 state값이 설정되어 있는데
    // key값을 통해 해당 위젯의 state값(ItemCount)을 증가시킴
    // if (_key.currentState != null) {
    //   _key.currentState!.insertItem(
    //     _items.length,
    //     duration: _duration,
    //   );
    //   _items.add(_items.length);
    // }
  }

  // void _deleteItem(int index) {
  //   if (_key.currentState != null) {
  //     // removceItem의 builder : 위젯이 사라지는 duration동안 해당 위젯을 대체하며 삭제됨
  //     // animation도 추가 가능
  //     _key.currentState!.removeItem(
  //       index,
  //       (context, animation) => SizeTransition(
  //         sizeFactor: animation,
  //         child: Container(
  //           color: Colors.red,
  //           child: _makeTile(index),
  //         ),
  //       ),
  //       duration: _duration,
  //     );
  //     _items.removeAt(index);
  //   }
  // }

  void _onChatTap(String chatId) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": chatId},
    );
  }

  // Widget _makeTile(int index) {
  //   return ListTile(
  //     onLongPress: () => _deleteItem(index),
  //     onTap: () => _onChatTap(index),
  //     leading: const CircleAvatar(
  //       radius: 25,
  //       foregroundImage: NetworkImage(
  //           "https://lh3.googleusercontent.com/a/AGNmyxYol5lNtQShTuXHxFwtUaHFG7SJ7NgONKeSCEz9jg=s96-c-rg-br100"),
  //       child: Text("JS"),
  //     ),
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         Text(
  //           "Camel ($index)",
  //           style: const TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         Text(
  //           "2:16 PM",
  //           style: TextStyle(
  //             color: Colors.grey.shade600,
  //             fontSize: Sizes.size12,
  //           ),
  //         )
  //       ],
  //     ),
  //     subtitle: const Text("Don't forget to make video"),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: const Text("Direct Message"),
        actions: [
          IconButton(
            onPressed: _onCreateChat,
            icon: const FaIcon(FontAwesomeIcons.plus),
          )
        ],
      ),
      body: ref.watch(chatsProvider).when(
            data: (data) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final chatRoom = data[index];
                  return GestureDetector(
                    onTap: () => _onChatTap(chatRoom.chatRoomId),
                    child: ListTile(
                      leading: const CircleAvatar(),
                      title: Text(chatRoom.personB),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
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
      // body: AnimatedList(
      //   key: _key,
      //   padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
      //   // itemBuilder를 통해 제공되는 context, index, animation
      //   itemBuilder: (context, index, animation) {
      //     return FadeTransition(
      //       key: Key("$index"),
      //       opacity: animation,
      //       child: SizeTransition(
      //         sizeFactor: animation,
      //         child: _makeTile(index),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
