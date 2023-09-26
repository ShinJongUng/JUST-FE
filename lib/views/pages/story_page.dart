import 'package:flutter/material.dart';
import 'package:just/models/post_arguments.dart';
import 'package:just/utils/test_data.dart';
import 'package:just/views/widgets/story_page/story_builder_widget.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late List<PostArguments> test;

  @override
  void initState() {
    super.initState();
    test = _fetchData();
  }

  List<PostArguments> _fetchData() {
    return TestData().data;
  }

  List<Widget> _buildStories() {
    return test.map((data) {
      return StoryBuilderWidget(
        numbersOfComments: data.numbersOfComments,
        numbersOfLikes: data.numbersOfLikes,
        bgImageId: data.bgImageId,
        pagesText: data.pagesText,
      );
    }).toList();
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
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: _buildStories(),
      ),
    );
  }
}
