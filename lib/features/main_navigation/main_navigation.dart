import 'package:flutter/cupertino.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Search'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    // CupertinoTabScaffold를 사용하려면 main.dart에서 CupertinoApp으로 전환해야 함
    return CupertinoTabScaffold(
      // CupertinoTabBar는 별도로 index state를 설정할 필요가 없음
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          )
        ],
      ),
      tabBuilder: (context, index) => screens[index],
    );
  }
}
