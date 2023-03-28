import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  // List 생성하기
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Activities"),
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            child: Text(
              "New",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Gaps.v14,
          for (var notification in _notifications)
            // Dismissible 위젯
            Dismissible(
              // direction은 좌우 상태값을 나타냄, 여기서는 필요없어서 미사용
              onDismissed: (direction) => _onDismissed(notification),
              // key값 String
              key: Key(notification),
              // background, secondBackground 설정
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.only(left: Sizes.size10),
                  child: FaIcon(
                    FontAwesomeIcons.checkDouble,
                    color: Colors.white,
                    size: Sizes.size32,
                  ),
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.only(right: Sizes.size10),
                  child: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.white,
                    size: Sizes.size32,
                  ),
                ),
              ),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                leading: Container(
                  width: Sizes.size48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.black,
                    ),
                  ),
                ),
                // RichText, TextSpan 위젯을 통해 다양한 text스타일 적용
                title: RichText(
                  text: TextSpan(
                    text: "Account updates:",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      const TextSpan(
                        text: " Upload longer videos",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: " 1h",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
