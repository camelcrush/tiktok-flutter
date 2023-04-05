import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/utils.dart';

import '../../../constants/size.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({
    Key? key,
    required this.inverted,
  }) : super(key: key);

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Stack(
      // clipBehavior : Stack은 기본적으로 Size에 제한을 둬서 벗어나는 범위는 가려버림, Clip.none으로 해제
      clipBehavior: Clip.none,
      children: [
        // Positioned : Stack 내부의 위젯들의 위치를 조정할 수 있는 위젯
        Positioned(
          right: 20,
          child: Container(
            // Container의 child가 없을 경우 height, width를 정해줘야함
            height: 30,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            height: 30,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
          ),
        ),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
          ),
          decoration: BoxDecoration(
            color: !inverted || isDark ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(Sizes.size6),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: !inverted || isDark ? Colors.black : Colors.white,
              size: 18,
            ),
          ),
        )
      ],
    );
  }
}
