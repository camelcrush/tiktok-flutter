import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/discover/discover_screen.dart';
import 'package:tiktokapp/features/inbox/inbox_screen.dart';
import 'package:tiktokapp/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktokapp/common/widgets/main_navigation/widgets/tab_nav.dart';
import 'package:tiktokapp/features/users/user_profile_screen.dart';
import 'package:tiktokapp/features/videos/views/video_recording_screen.dart';
import 'package:tiktokapp/features/videos/views/videos_timeline_screen.dart';
import 'package:tiktokapp/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";
  final String tab;

  const MainNavigationScreen({
    Key? key,
    required this.tab,
  }) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = isDarkMode(context);

    // CupertinoTabScaffold를 사용하려면 main.dart에서 CupertinoApp으로 전환해야 함
    return Scaffold(
      // Keyboard가 올라올 때 Scaffold 화면을 resize하는 것을 false
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      // Stateful Widget으로 된 화면 렌더링을 가진 Navigator에서 탭간 이동 시에 State값이
      // 초기화되는 현상을 해결하기 위해 Stack, Offstage 위젯을 쓴다. (State값을 기억함)
      // Stack : 화면 또는 위젯을 쌓아 올리는 위젯
      body: Stack(
        children: [
          // Stack 내부의 위젯들을 숨겨주는 위젯
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "Camel",
              tab: "",
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + Sizes.size12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabNav(
                text: 'Home',
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              TabNav(
                text: 'Discover',
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(
                  inverted: _selectedIndex != 0,
                ),
              ),
              Gaps.h24,
              TabNav(
                text: 'Inbox',
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              TabNav(
                text: 'Profile',
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              )
            ],
          ),
        ),
      ),
    );
  }
}
