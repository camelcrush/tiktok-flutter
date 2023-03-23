import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({Key? key}) : super(key: key);

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery를 통해 사용자 device사이를 알아냄
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      // 자식인 Scaffold가 직사각형이기 때문에 Container 범위에 맞게 잘라 줄려면
      // 튀어나온 부분을 clipBehavior를 통해 잘라줌
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _onPressed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            ),
          ],
          title: const Text("2,399 comments"),
        ),
        // Comments의 댓글입력 TextField()의 키보드 때문에 Stack으로 ListView를 보여주고
        // Positioned(), bottom:0을 통해 아래 Input창을 배치해 주기로 함
        body: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size20,
              ),
              separatorBuilder: (context, index) => Gaps.v20,
              itemCount: 10,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 18,
                    child: Text(
                      "Camel",
                      style: TextStyle(fontSize: Sizes.size12),
                    ),
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Camel",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Gaps.v3,
                        const Text(
                            "That's not it l've seen the same thing but also in a cave,")
                      ],
                    ),
                  ),
                  Gaps.h10,
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: Sizes.size20,
                        color: Colors.grey.shade600,
                      ),
                      Gaps.v2,
                      Text(
                        '52.2K',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              // TextFeild()를 감싸는 위젯은 반드시 width를 정해줘야 함
              width: size.width,
              child: BottomAppBar(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade600,
                        foregroundColor: Colors.white,
                        child: const Text(
                          "Camel",
                          style: TextStyle(
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            hintText: 'Add comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                Sizes.size12,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: Sizes.size10,
                              horizontal: Sizes.size12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
