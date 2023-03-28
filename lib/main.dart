import 'package:flutter/material.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/inbox/activity_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok App',
      // 전체 Theme 설정
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.white,
        // Text Input Cursor Color 글로벌 설정
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        // Splash Effect Global 설정, splashColor, highlightColor
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          // Back Button Color Theme 설정
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      home: const ActivityScreen(),
    );
  }
}
