import 'package:flutter/material.dart';

class StoryUserPostsWidget extends StatefulWidget {
  final pageController;
  final List<dynamic> pagesText;
  final Function(int) changeSelectedPage;
  const StoryUserPostsWidget(
      {super.key,
      required this.pagesText,
      required this.pageController,
      required this.changeSelectedPage});

  @override
  State<StoryUserPostsWidget> createState() => _StoryUserPostsWidgetState();
}

class _StoryUserPostsWidgetState extends State<StoryUserPostsWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: widget.pageController,
      onPageChanged: widget.changeSelectedPage,
      children: <Widget>[
        if (widget.pagesText.isNotEmpty)
          for (var text in widget.pagesText)
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent, // 배경색을 투명으로 설정
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: Text(
                    text.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 1.5,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
