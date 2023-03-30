import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/utils/test_data.dart';
import 'package:just/views/widgets/story_page/story_builder_widget.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final test = TestData().data;

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
              Get.toNamed('/search');
            },
          ),
        ],
      ),
      body: PageView(
        onPageChanged: (int index) {
          setState(() {});
        },
        scrollDirection: Axis.vertical,
        children: <Widget>[
          for (var t in test)
            StoryBuilderWidget(
              numbersOfComments: t['numbersOfComments'].toString(),
              numbersOfLikes: t['numbersOfLikes'].toString(),
              bgImage: t['bgImage'].toString(),
              pagesText: t['pagesText'],
            ),
        ],
      ),
    );
  }
}
