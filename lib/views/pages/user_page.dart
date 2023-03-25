import 'package:flutter/material.dart';
import 'package:just/views/widgets/user_posts/user_toggle_widget.dart';
import 'package:just/views/widgets/user_profile_card.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text('마이페이지'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // 설정 페이지로 이동하는 코드 작성
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
        body: NestedScrollView(
            physics: const ClampingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverAppBar(
                  expandedHeight: 110,
                  flexibleSpace: FlexibleSpaceBar(
                    background: UserProfileCard(),
                  ),
                ),
              ];
            },
            body: const UserToggleWidget()));
  }
}
