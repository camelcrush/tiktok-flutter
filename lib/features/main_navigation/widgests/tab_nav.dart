import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';

class TabNav extends StatelessWidget {
  const TabNav({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  }) : super(key: key);

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    // Expanded : Row나 Column등에서 핸드폰 화면에 맞게 균일하게 배치하기 위해서 사용함.
    // 부모의 남은 범위를 flex의 비율에 맞춰서 "모두" 가져간다. 여기서는 MainNavigation의 Row
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          // Container에 color값을 주어야 자체적으로 공간을 Expanded함
          color: selectedIndex == 0 ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.5,
            duration: const Duration(milliseconds: 300),
            child: Column(
              // Column은 기본적으로 화면을 전부 사용할려고 하기 때문에 MainAxisSize.min으로 자식 사이즈에 맞춤
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
