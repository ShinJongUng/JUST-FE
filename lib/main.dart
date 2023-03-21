import 'package:flutter/material.dart';
import 'package:just/home_page.dart';
import 'package:just/views/pages/post_page.dart';
import 'package:just/views/pages/search_page.dart';
import 'package:just/views/pages/user_post_page.dart';

void main() {
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
