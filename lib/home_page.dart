import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/getX/post_controller.dart';
import 'package:just/views/pages/post_page.dart';
import 'package:just/views/pages/story_page.dart';
import 'package:just/views/pages/user_info_page.dart';
import 'package:just/views/widgets/utils/login_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    final LoginController lc = Get.put(LoginController());
    final PostController pc = Get.put(PostController());

    if (lc.isLogin == false) {
      if (index == 0) {
        return;
      }
      showDialog(context: context, builder: (context) => const LoginDialog());
      return;
    }
    if (index == 1) {
      Get.toNamed("/post");

      return;
    }
    if (index == 0) {
      pc.refreshPosts();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    StoryPage(),
    Placeholder(),
    UserInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _navigateBottomBar,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.greenAccent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_none),
              label: '고민',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 45,
                color: Colors.greenAccent,
              ),
              label: '글 쓰기',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '프로필',
            ),
          ],
        ));
  }
}

Route createPostRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PostPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset.zero;
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
