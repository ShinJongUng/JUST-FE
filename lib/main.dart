import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just/home_page.dart';
import 'package:just/views/pages/login_page.dart';
import 'package:just/views/pages/post_page.dart';
import 'package:just/views/pages/search_page.dart';
import 'package:just/views/pages/signup_page.dart';
import 'package:just/views/pages/user_post_page.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
        '/post': (context) => PostPage(),
        '/user-post': (context) => UserPostPage(),
        '/search': (context) => SearchPage(),
        '/login': (context) => const LoginPage(),
        '/sign-up': (context) => SignUpPage()
      },
    );
  }
}
