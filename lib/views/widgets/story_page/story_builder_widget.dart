import 'package:flutter/material.dart';
import 'package:just/views/widgets/story_page/story_frame_widget.dart';
import 'package:just/views/widgets/story_page/story_user_posts_widget.dart';

class StoryBuilderWidget extends StatefulWidget {
  final String numbersOfComments;
  final String numbersOfLikes;
  final String bgImage;
  final List<dynamic> pagesText;

  const StoryBuilderWidget({
    super.key,
    required this.numbersOfComments,
    required this.numbersOfLikes,
    required this.bgImage,
    required this.pagesText,
  });

  @override
  State<StoryBuilderWidget> createState() => _StoryBuilderWidgetState();
}

class _StoryBuilderWidgetState extends State<StoryBuilderWidget> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  void changeSelectedPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoryFrameWidget(
        numbersOfComments: widget.numbersOfComments,
        numbersOfLikes: widget.numbersOfLikes,
        postLength: widget.pagesText.length,
        selectPage: selectedPage,
        userPost: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.7,
                fit: BoxFit.cover,
                image: AssetImage(widget.bgImage), // 배경 이미지
              ),
            ),
          ),
          StoryUserPostsWidget(
            pagesText: widget.pagesText,
            pageController: _pageController,
            changeSelectedPage: changeSelectedPage,
          ),
        ]));
  }
}
