import 'package:flutter/material.dart';
import 'package:just/views/widgets/user_info_page/user_comment_widget.dart';
import 'package:just/views/widgets/user_info_page/user_post_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';

class UserToggleWidget extends StatefulWidget {
  const UserToggleWidget({super.key});

  @override
  State<UserToggleWidget> createState() => _UserToggleWidgetState();
}

class _UserToggleWidgetState extends State<UserToggleWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: Container(
        color: const Color.fromARGB(255, 48, 48, 48),
        child: TabBar(controller: _tabController, tabs: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: const Text(
              '작성 글',
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: const Text(
              '작성 댓글',
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: const Text(
              '좋아요한 글',
            ),
          ),
        ]),
      ),
      content: SizedBox(
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 40),
              key: PageStorageKey('user_posts'),
              itemCount: 10,
              itemBuilder: (context, index) => const UserPostWidget(
                title: 'ㅎㅇㅎㅇ',
                numbersOfComments: 10,
                numbersOfLikes: 20,
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 40),
              key: PageStorageKey('user_comments'),
              itemCount: 10,
              itemBuilder: (context, index) => const UserCommentWidget(
                comments: '하이루',
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 40),
              key: PageStorageKey('like_posts'),
              itemCount: 10,
              itemBuilder: (context, index) => const UserPostWidget(
                title: '해윙',
                numbersOfComments: 10,
                numbersOfLikes: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
