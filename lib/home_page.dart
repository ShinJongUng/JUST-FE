import 'package:flutter/material.dart';
import 'package:just/views/pages/post_page.dart';
import 'package:just/views/pages/story_page.dart';
import 'package:just/views/pages/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    if (index == 1) {
      Navigator.of(context).push(createPostRoute());
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    StoryPage(),
    const Placeholder(),
    UserPage(),
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
