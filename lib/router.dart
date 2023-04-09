import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/email_screen.dart';
import 'package:tiktokapp/features/authentication/login_screen.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';
import 'package:tiktokapp/features/authentication/username_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: UsernameScreen.routeName,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) => const EmailScreen(),
    ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        return UsernameScreen(username: username!);
      },
    )
  ],
);
