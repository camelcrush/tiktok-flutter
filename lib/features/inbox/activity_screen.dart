import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Activities"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        children: [
          Gaps.v14,
          Text(
            "New",
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.grey.shade600,
            ),
          ),
          Gaps.v14,
          ListTile(
            contentPadding: EdgeInsets.zero,
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
        ],
      ),
    );
  }
}
