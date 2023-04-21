import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/settings/settings_screen.dart';
import 'package:tiktokapp/features/users/edit_profile_screen.dart';
import 'package:tiktokapp/features/users/view_models/users_view_model.dart';
import 'package:tiktokapp/features/users/widgets/avatar.dart';
import 'package:tiktokapp/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktokapp/utils.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    Key? key,
    required this.username,
    required this.tab,
  }) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onEditPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == 'likes' ? 1 : 0,
                length: 2,
                // CustomScrollView는 Sliver 속성의 위젯만 쓸 수 있음
                // NestedScrollView : Sliver속성과 TabBar의 스크롤 중첩문제로 인해 사용이 불가한 CustomScrollView를 보완한 위젯
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        centerTitle: true,
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onEditPressed,
                            icon: const Icon(
                              Icons.edit,
                              size: Sizes.size20,
                            ),
                          ),
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Avatar(
                              uid: data.uid,
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                            ),
                            Gaps.v24,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Sizes.size18,
                                  ),
                                ),
                                Gaps.h5,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: Sizes.size14,
                                  color: Colors.blue.shade500,
                                ),
                              ],
                            ),
                            Gaps.v24,
                            // VerticalDivider를 사용하기 위해 SizeBox를 통해 Row의 height를 설정
                            SizedBox(
                              height: Sizes.size48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "97",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v1,
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                  // VerticalDivider는 부모의 height가 필요함
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                    color: Colors.grey.shade600,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "10M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v1,
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                    color: Colors.grey.shade600,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "194.3M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v1,
                                      Text(
                                        "Likes",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size12,
                                    horizontal: Sizes.size40,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size4),
                                    ),
                                  ),
                                  child: const Text(
                                    "Follow",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Gaps.h5,
                                Container(
                                  padding: const EdgeInsets.all(Sizes.size12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                      width: 0.5,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size4),
                                    ),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: Sizes.size14,
                                    color: isDark ? Colors.grey.shade200 : null,
                                  ),
                                ),
                                Gaps.h5,
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size12,
                                    horizontal: Sizes.size14,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade600,
                                      width: 0.5,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size4),
                                    ),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.sortDown,
                                    size: Sizes.size14,
                                    color: isDark ? Colors.grey.shade200 : null,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v14,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size32),
                              child: Text(
                                data.bio,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  data.link,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      // Pinned되는 header 생성 위젯
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      )
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        // GridView의 keyboardDismiss Prop
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size1,
                          mainAxisSpacing: Sizes.size1,
                          childAspectRatio: 9 / 14,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 14,
                                  // FadeInImage.assetNetwork : 이미지 로딩 시 placeholder사진 미리 보여주기
                                  child: FadeInImage.assetNetwork(
                                    // Boxfit : Image 사이즈 조정
                                    fit: BoxFit.cover,
                                    placeholder:
                                        "assets/images/placeholder.jpeg",
                                    image:
                                        "https://source.unsplash.com/random/200x${355 + index}",
                                  ),
                                ),
                                Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Row(
                                      children: const [
                                        FaIcon(
                                          FontAwesomeIcons.play,
                                          color: Colors.white,
                                          size: Sizes.size14,
                                        ),
                                        Gaps.h10,
                                        Text(
                                          "2.9M",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("Page 2"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
