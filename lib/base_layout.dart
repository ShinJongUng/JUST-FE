import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/getX/post_controller.dart';
import 'package:just/models/post_type_arguments.dart';
import 'package:just/views/pages/story_page.dart';
import 'package:just/views/pages/user_info_page.dart';
import 'package:just/views/widgets/utils/login_dialog.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  int _selectedIndex = 0;
  final LoginController _loginController = Get.find();
  final PostController _postController = Get.find();

  void _navigateBottomBar(int index) {
    if (!_loginController.isLogin && index != 0) {
      _showLoginDialog();
      return;
    }

    if (index == 1) {
      Get.toNamed("/post", arguments: PostTypeArguments(-1, 'write'));
      return;
    }

    if (index == 0) {
      _postController.refreshPosts();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void _showLoginDialog() {
    showDialog(context: context, builder: (context) => const LoginDialog());
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int? pageIndexArguments =
          ModalRoute.of(context)?.settings.arguments as int?;

      if (pageIndexArguments != null &&
          pageIndexArguments >= 0 &&
          pageIndexArguments < _pages.length) {
        setState(() {
          _selectedIndex = pageIndexArguments;
        });
      }
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
            label: 'Story',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 45, color: Colors.greenAccent),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
