import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/authentication/sign_up_screen.dart';
import 'package:tiktokapp/generated/l10n.dart';

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
    // 앱 Locale 변환하기
    // S.load(const Locale('ko'));
    return MaterialApp(
      title: 'TikTok App',
      // Locale Flutter 자체 가지고 있는 텍스트 번역본 실행
      // cmd에서 flutter gen-l10n 실행
      // .dart_tool/flutter_gen/gen_l10n에서 intl_generate.dart import
      // 위 과정을 flutter intl extension으로 대체
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      debugShowCheckedModeBanner: false,
      // Light/Dark Mode를 앱애 설정에 따라 설정
      themeMode: ThemeMode.system,
      // 전체 Theme 설정
      // 앱 개발 할 때 Material Design 2의 generator를 통해 설정을 해서 시작하는 것이 좋음
      // Size와 FontWeight를 미리 설정하여 TextTheme을 활용하여 TextStyle에 통일성을 줄 수 있음
      theme: ThemeData(
          useMaterial3: true,
          // textTheme: TextTheme(
          //   displayLarge: GoogleFonts.openSans(
          //       fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          //   displayMedium: GoogleFonts.openSans(
          //       fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          //   displaySmall:
          //       GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
          //   headlineMedium: GoogleFonts.openSans(
          //       fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          //   headlineSmall:
          //       GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
          //   titleLarge: GoogleFonts.openSans(
          //       fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          //   titleMedium: GoogleFonts.openSans(
          //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          //   titleSmall: GoogleFonts.openSans(
          //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          //   bodyLarge: GoogleFonts.roboto(
          //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          //   bodyMedium: GoogleFonts.roboto(
          //       fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          //   labelLarge: GoogleFonts.roboto(
          //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          //   bodySmall: GoogleFonts.roboto(
          //       fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          //   labelSmall: GoogleFonts.roboto(
          //       fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          // ),

          // Google Fonts를 이용한 단일 폰트 설정
          // textTheme: GoogleFonts.itimTextTheme(),

          // Google Fonts를 이용하지 않고 Typography를 통해 폰트 설정
          textTheme: Typography.blackMountainView,
          // brightness : Text 위젯 Default Color
          brightness: Brightness.light,
          primaryColor: const Color(0xFFE9435A),
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
          ),
          // Text Input Cursor Color 글로벌 설정
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          // Splash Effect Global 설정, splashColor, highlightColor
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            // surfaceTintColor : Material 3일 때 AppBar 배경색
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            // foregroundColor : text 색 설정
            foregroundColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
            // Back Button Color Theme 설정
            iconTheme: IconThemeData(color: Colors.black87),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          )),
      darkTheme: ThemeData(
        useMaterial3: true,
        // textTheme: TextTheme(
        //   displayLarge: GoogleFonts.openSans(
        //       fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        //   displayMedium: GoogleFonts.openSans(
        //       fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        //   displaySmall:
        //       GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
        //   headlineMedium: GoogleFonts.openSans(
        //       fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        //   headlineSmall:
        //       GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
        //   titleLarge: GoogleFonts.openSans(
        //       fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        //   titleMedium: GoogleFonts.openSans(
        //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        //   titleSmall: GoogleFonts.openSans(
        //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        //   bodyLarge: GoogleFonts.roboto(
        //       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        //   bodyMedium: GoogleFonts.roboto(
        //       fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        //   labelLarge: GoogleFonts.roboto(
        //       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        //   bodySmall: GoogleFonts.roboto(
        //       fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        //   labelSmall: GoogleFonts.roboto(
        //       fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        // ),

        // Google Fonts를 이용한 단일 폰트 설정
        // textTheme: GoogleFonts.itimTextTheme(
        //   ThemeData(brightness: Brightness.dark).textTheme,
        // ),

        // Google Fonts를 이용하지 않고 Typography를 통해 폰트 설정
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        appBarTheme: AppBarTheme(
          // surfaceTintColor : Material 3일 때 AppBar 배경색
          surfaceTintColor: Colors.grey.shade900,
          backgroundColor: Colors.grey.shade900,
          // foregroundColor : text 색 설정
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.white,
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}
