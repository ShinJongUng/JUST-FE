import 'package:flutter/material.dart';
import 'package:just/views/widgets/story_page/story_frame_widget.dart';
import 'package:just/views/widgets/story_page/story_user_posts_widget.dart';

class StoryBuilderWidget extends StatefulWidget {
  final int numbersOfComments;
  final int numbersOfLikes;
  final int bgImageId;
  final List<dynamic> pagesText;
  final int postId;
  final bool isLike;

  const StoryBuilderWidget({
    super.key,
    required this.numbersOfComments,
    required this.numbersOfLikes,
    required this.bgImageId,
    required this.pagesText,
    required this.postId,
    required this.isLike,
  });

  @override
  State<StoryBuilderWidget> createState() => _StoryBuilderWidgetState();
}

class _StoryBuilderWidgetState extends State<StoryBuilderWidget> {
  late int selectedPage;
  late final PageController _pageController;
  late TapDownDetails _tapDownDetails;
  bool isImageLoading = true;

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

  void tapPage() {
    if (widget.pagesText.length <= 1) {
      return;
    }
    if (selectedPage < widget.pagesText.length - 1 && _isTappingRightSide()) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedPage++;
      });
    } else if (selectedPage > 0 && _isTappingLeftSide()) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        selectedPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoryFrameWidget(
        postId: widget.postId,
        isLike: widget.isLike,
        numbersOfComments: widget.numbersOfComments,
        numbersOfLikes: widget.numbersOfLikes,
        postLength: widget.pagesText.length,
        selectPage: selectedPage,
        userPost: GestureDetector(
          onTapDown: (TapDownDetails details) {
            _tapDownDetails = details;
          },
          onTap: tapPage,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "assets/test${widget.bgImageId}.jpg"), // 배경 이미지
                ),
              ),
            ),
            StoryUserPostsWidget(
              pagesText: widget.pagesText,
              pageController: _pageController,
              changeSelectedPage: changeSelectedPage,
            ),
          ]),
        ));
  }

  bool _isTappingLeftSide() {
    return _tapDownDetails.localPosition.dx <
        MediaQuery.of(context).size.width / 3;
  }

  bool _isTappingRightSide() {
    return _tapDownDetails.localPosition.dx >
        MediaQuery.of(context).size.width / 3 * 2;
  }
}
