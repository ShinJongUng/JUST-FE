import 'package:flutter/material.dart';
import 'package:just/views/widgets/story_view/post_widget.dart';

class PagePostWidget extends StatefulWidget {
  final String numbersOfComments;
  final String numbersOfLikes;
  final String bgImage;
  final List<dynamic> pagesText;

  const PagePostWidget({
    super.key,
    required this.numbersOfComments,
    required this.numbersOfLikes,
    required this.bgImage,
    required this.pagesText,
  });

  @override
  State<PagePostWidget> createState() => _PagePostWidgetState();
}

class _PagePostWidgetState extends State<PagePostWidget> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PostWidget(
        numbersOfComments: widget.numbersOfComments,
        numbersOfLikes: widget.numbersOfLikes,
        postLength: widget.pagesText.length,
        selectPage: selectedPage,
        userPost: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.7,
                  fit: BoxFit.cover,
                  image: AssetImage(widget.bgImage), // 배경 이미지
                ),
              ),
            ),
            PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              children: <Widget>[
                if (widget.pagesText.isNotEmpty)
                  for (var text in widget.pagesText)
                    Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent, // 배경색을 투명으로 설정
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            )
          ],
        ));
  }
}
