import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      // List.addAll([]) : List에 data 일괄 추가
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.teal,
      ]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ListView와 같이 builder를 통해 preloader 기능을 이용
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index",
            style: const TextStyle(fontSize: 68),
          ),
        ),
      ),
    );
  }
}
