import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  // Input Data 초기값 설정
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initail Value");

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Tab간 이동 시 KeyboardDismiss를 위한 컨트롤러 Init
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      // Controller Instance 변화 시 unfocus
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void _onSearchChanged(String value) {
    print("Searching form $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TabBar 혹은 TabBarView를 사용하려면 Controller가 필요
    // DefaultTabController를 사용
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            // CupertinoSearchTextField
            title: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
              autocorrect: false,
            ),
            bottom: TabBar(
              controller: _tabController,
              // splash effect 제거
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  )
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              GridView.builder(
                // GridView의 keyboardDismiss Prop
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: const EdgeInsets.all(
                  Sizes.size10,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(fontSize: 28),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
