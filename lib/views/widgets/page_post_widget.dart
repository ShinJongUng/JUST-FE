import 'package:flutter/material.dart';
import 'package:just/views/widgets/post_widget.dart';

class PagePostWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return PostWidget(
        numbersOfComments: numbersOfComments,
        numbersOfLikes: numbersOfLikes,
        userPost: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.7,
                  fit: BoxFit.cover,
                  image: AssetImage(bgImage), // 배경 이미지
                ),
              ),
            ),
            PageView(
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                if (pagesText.isNotEmpty)
                  for (var text in pagesText)
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
