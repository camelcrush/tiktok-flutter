import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/email_screen.dart';
import 'package:tiktokapp/features/authentication/login_screen.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';
import 'package:tiktokapp/features/authentication/username_screen.dart';
import 'package:tiktokapp/features/users/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
        routes: [
          GoRoute(
              name: UsernameScreen.routeName,
              path: UsernameScreen.routeURL,
              builder: (context, state) => const UsernameScreen(),
              routes: [
                GoRoute(
                  name: EmailScreen.routeName,
                  path: EmailScreen.routeName,
                  builder: (context, state) {
                    final args = state.extra as EmailScreenArgs;
                    return EmailScreen(username: args.username);
                  },
                )
              ])
        ]),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    // GoRoute(
    //   path: UsernameScreen.routeName,
    //   pageBuilder: (context, state) {
    //     // animation 효과 custom
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: ScaleTransition(
    //             scale: animation,
    //             child: child,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams['show'];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    )
  ],
);
