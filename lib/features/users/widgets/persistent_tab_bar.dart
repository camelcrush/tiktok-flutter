import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/size.dart';

// SliverPersistentHeader : 중간에서 Header가 고정되는 delegate class
class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: const TabBar(
        labelPadding: EdgeInsets.symmetric(vertical: Sizes.size8),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size14),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size14),
            child: FaIcon(FontAwesomeIcons.heart),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 43;

  @override
  double get minExtent => 43;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
