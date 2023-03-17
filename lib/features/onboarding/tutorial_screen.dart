import 'package:flutter/material.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    // DefaultTabController > TabBarView 위젯 : 스와이프 화면 구성
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    'Watch cool videos!',
                    style: TextStyle(
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    'Follow the rules!',
                    style: TextStyle(
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    'Enjoy the ride',
                    style: TextStyle(
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like, and share.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // BottomAppBar가 DefaultTabController 밑에 있기 때문에 스와이프가 자동 설정됨
                TabPageSelector(
                  selectedColor: Colors.black38,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
