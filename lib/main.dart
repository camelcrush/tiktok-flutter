import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';

void main() async {
  // runApp 시키기 전에 Widget과 Flutter egineed을 binding시키기 위함
  // runApp 전에 State설정이 필요할 때 사용
  WidgetsFlutterBinding.ensureInitialized();

// SystemChrome을 통해 디바이스 기본방향으로 세로화면만을 설정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

// SystemChrome.setSystemUIOverlayStyle : 기본 스타일 색상모드 설정
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok App',
      debugShowCheckedModeBanner: false,
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
      home: const SignUpScreen(),
    );
  }
}
