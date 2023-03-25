import 'package:flutter/material.dart';
import 'package:just/utils/test_data.dart';
import 'package:just/views/widgets/story_view/page_post_widget.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final test = TestData().data;
  bool _isLoading = false;
  int _currentPageIndex = 0;

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
    });

    // 로딩 시간을 대기
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('글'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: PageView(
          onPageChanged: (int index) {
            setState(() {
              _currentPageIndex = index;
              _isLoading = (index == test.length - 1);
            });
          },
          scrollDirection: Axis.vertical,
          children: <Widget>[
            for (var t in test)
              PagePostWidget(
                numbersOfComments: t['numbersOfComments'].toString(),
                numbersOfLikes: t['numbersOfLikes'].toString(),
                bgImage: t['bgImage'].toString(),
                pagesText: t['pagesText'],
              ),
          ],
        ),
      ),
    );
  }
}
