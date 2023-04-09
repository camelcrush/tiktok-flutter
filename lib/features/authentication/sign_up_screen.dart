import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/authentication/login_screen.dart';
import 'package:tiktokapp/features/authentication/username_screen.dart';
import 'package:tiktokapp/features/authentication/widgets/auth_button.dart';
import 'package:tiktokapp/generated/l10n.dart';
import 'package:tiktokapp/utils.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "signUp";
  static String routeURL = "/";
  const SignUpScreen({Key? key}) : super(key: key);

// push : 화면을 위에 올려놓는것.
// pop: 화면 제일위에 있는걸 빼 내어서 기존 화면으로 돌아가게 함.
// Dart에서 private 개념은 없으나 명시적으로 _표시를 둠
  void _onLoginTap(BuildContext context) async {
    // // push는 Future 타입으로 pop으로부터 데이터를 받아올 수 있음
    // final result = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const LoginScreen(),
    //   ),
    // );
    // if (kDebugMode) {
    //   print(result);
    // }

    // Navigator.of(context).pushNamed(LoginScreen.routeName);
    context.push(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    // Navigator.of(context).push(
    //   // PageRouteBuilder를 통해 Animation 효과를 줄 수 있음
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(seconds: 1),
    //     reverseTransitionDuration: const Duration(seconds: 1),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       // animation값은 Double을 요구하지만 offsetAnimation : Tween을 통해 Animation값을 별도로 만들 수 있음
    //       final offsetAnimation = Tween(
    //         begin: const Offset(1, 0),
    //         end: Offset.zero,
    //       ).animate(animation);
    //       //  final opacityAnimation = Tween(
    //       //     begin: 0.5,
    //       //     end: 1.0,
    //       //   ).animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // );

    // Navigator.of(context).pushNamed(UsernameScreen.routeName);
    context.pushNamed(UsernameScreen.routeName);

    // queryParams 예시
    // context.push("/users/camel?show=likes");
  }

  @override
  Widget build(BuildContext context) {
    // OrientationBuilder : orientation을 통해 디바이스의 방향을 알려줌
    return OrientationBuilder(
      builder: (context, orientation) {
        // if (orientation == Orientation.landscape) {
        //   return const Scaffold(
        //     body: Center(
        //       child: Text("Plz rotate your phon"),
        //     ),
        //   );
        // }
        return Scaffold(
          // SafeArea : 상단 여러가지 폰의 정보 아래에서 시작
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gaps.v80,
                  // TextTheme을 통한 Style 설정
                  Text(
                    S.of(context).signUpTitle('TikTok', DateTime.now()),
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubTitle(999),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: S.of(context).emailPasswordButton,
                      ),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      text: S.of(context).appleButton,
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: AuthButton(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: S.of(context).emailPasswordButton,
                            ),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            text: S.of(context).appleButton,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          //bottomNavigationBar: BottomAppBar 아랫부분에 로그인
          bottomNavigationBar: Container(
            color: isDarkMode(context)
                ? Theme.of(context).appBarTheme.backgroundColor
                : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).logIn('female'),
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
