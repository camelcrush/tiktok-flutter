import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/common/widgets/main_navigation/main_navigation.dart';
import 'package:tiktokapp/features/authentication/login_screen.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repo.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';
import 'package:tiktokapp/features/inbox/activity_screen.dart';
import 'package:tiktokapp/features/inbox/chat_detail_screen.dart';
import 'package:tiktokapp/features/inbox/chats_screen.dart';
import 'package:tiktokapp/features/onboarding/interests_screen.dart';
import 'package:tiktokapp/features/videos/views/video_recording_screen.dart';

// RiverPod Provider로 감싼 GoRouter : ref를 통해 어디서든지 접근할 수 있음
final routerProvider = Provider(
  (ref) {
    // Stream을 통해 signOut하는 방법
    // ref.watch(authState);
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final user = ref.read(authRepo).user;
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        // 로그인이 안 되었다면 현재 위치를 SignUpScreen으로 redirect
        if (!isLoggedIn) {
          // state.subloc : The location of this sub-rout
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: InterestsScreen.routeName,
          path: InterestsScreen.routeURL,
          builder: (context, state) => const InterestsScreen(),
        ),
        GoRoute(
          name: MainNavigationScreen.routeName,
          path: "/:tab(home|discover|inbox|profile)",
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
        ),
        GoRoute(
          path: ActivityScreen.routeURL,
          name: ActivityScreen.routeName,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          path: ChatsScreen.routeURL,
          name: ChatsScreen.routeName,
          builder: (context, state) => const ChatsScreen(),
          routes: [
            GoRoute(
              path: ChatDetailScreen.routeURL,
              name: ChatDetailScreen.routeName,
              builder: (context, state) {
                final chatId = state.params['chatId']!;
                return ChatDetailScreen(chatId: chatId);
              },
            )
          ],
        ),
        GoRoute(
          path: VideoRecordingScreen.routeURL,
          name: VideoRecordingScreen.routeName,
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 200),
            child: const VideoRecordingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position = Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
        )
      ],
    );
  },
);

// final router = GoRouter(
//   routes: [
//     GoRoute(
//         name: SignUpScreen.routeName,
//         path: SignUpScreen.routeURL,
//         builder: (context, state) => const SignUpScreen(),
//         routes: [
//           GoRoute(
//               name: UsernameScreen.routeName,
//               path: UsernameScreen.routeURL,
//               builder: (context, state) => const UsernameScreen(),
//               routes: [
//                 GoRoute(
//                   name: EmailScreen.routeName,
//                   path: EmailScreen.routeName,
//                   builder: (context, state) {
//                     final args = state.extra as EmailScreenArgs;
//                     return EmailScreen(username: args.username);
//                   },
//                 )
//               ])
//         ]),
//     GoRoute(
//       name: LoginScreen.routeName,
//       path: LoginScreen.routeURL,
//       builder: (context, state) => const LoginScreen(),
//     ),
//     // GoRoute(
//     //   path: UsernameScreen.routeName,
//     //   pageBuilder: (context, state) {
//     //     // animation 효과 custom
//     //     return CustomTransitionPage(
//     //       child: const UsernameScreen(),
//     //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//     //         return FadeTransition(
//     //           opacity: animation,
//     //           child: ScaleTransition(
//     //             scale: animation,
//     //             child: child,
//     //           ),
//     //         );
//     //       },
//     //     );
//     //   },
//     // ),
//     GoRoute(
//       path: "/users/:username",
//       builder: (context, state) {
//         final username = state.params['username'];
//         final tab = state.queryParams['show'];
//         return UserProfileScreen(username: username!, tab: tab!);
//       },
//     )
//   ],
// );
