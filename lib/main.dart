import 'package:flutter/material.dart';
import 'package:just/home_page.dart';
import 'package:just/views/pages/post_page.dart';
import 'package:just/views/pages/search_page.dart';
import 'package:just/views/pages/user_post_page.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'dad63e43a8ce025715c3181d98cbf26c');
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
      },
    );
  }
}
