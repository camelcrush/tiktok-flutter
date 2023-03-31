import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // CustomScrollView는 Sliver 속성의 위젯만 쓸 수 있음
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Camel"),
            actions: [
              IconButton(
                onPressed: () {},
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
                const CircleAvatar(
                  radius: 50,
                  foregroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/a/AGNmyxYol5lNtQShTuXHxFwtUaHFG7SJ7NgONKeSCEz9jg=s96-c-rg-br100"),
                  child: Text("Camel"),
                ),
                Gaps.v24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "@Camel",
                      style: TextStyle(
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
                            style: TextStyle(color: Colors.grey.shade600),
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
                            style: TextStyle(color: Colors.grey.shade600),
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
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gaps.v14,
                FractionallySizedBox(
                  widthFactor: 0.33,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size12,
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
                ),
                Gaps.v14,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                  child: Text(
                    "All highlights and where to watch live matches on FIFA+ I wonder how it would loook",
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.link,
                      size: Sizes.size12,
                    ),
                    Gaps.h4,
                    Text(
                      "https://nomadcoders.co",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Gaps.v20,
                Container(
                  decoration: BoxDecoration(
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
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      // GridView의 keyboardDismiss Prop
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: 20,
                      padding: const EdgeInsets.all(
                        Sizes.size10,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: Sizes.size10,
                        mainAxisSpacing: Sizes.size10,
                        childAspectRatio: 9 / 20,
                      ),
                      itemBuilder: (context, index) => Column(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Sizes.size5),
                            ),
                            // AspectRatio: 이미지 비율대로 공간 조정해주는 위젯
                            child: AspectRatio(
                              aspectRatio: 9 / 16,
                              // FadeInImage.assetNetwork : 이미지 로딩 시 placeholder사진 미리 보여주기
                              child: FadeInImage.assetNetwork(
                                // Boxfit : Image 사이즈 조정
                                fit: BoxFit.cover,
                                placeholder: "assets/images/placeholder.jpeg",
                                image:
                                    "https://source.unsplash.com/random/200x${355 + index}",
                              ),
                            ),
                          ),
                          Gaps.v10,
                          const Text(
                            'This is a very long caption for my tiktok that im upload just now currently.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.v8,
                          // DefaultTextStyle 설정
                          DefaultTextStyle(
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage(
                                      "https://lh3.googleusercontent.com/a/AGNmyxYol5lNtQShTuXHxFwtUaHFG7SJ7NgONKeSCEz9jg=s96-c-rg-br100"),
                                ),
                                Gaps.h4,
                                const Expanded(
                                  child: Text(
                                    "My avatar is going to be very long",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Gaps.h4,
                                FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: Sizes.size12,
                                  color: Colors.grey.shade600,
                                ),
                                Gaps.h2,
                                const Text("2.5M")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Center(
                      child: Text("Page 2"),
                    )
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
