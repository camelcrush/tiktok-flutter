import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Container(
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
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            child: const Text('Comments'),
          ),
        ),
      ),
    );
  }
}
