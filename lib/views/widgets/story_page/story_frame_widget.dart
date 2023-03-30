import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/views/widgets/story_page/comment_sheet_button.dart';
import 'package:just/views/widgets/story_page/icon_button.dart';
import 'package:just/views/widgets/utils/login_dialog.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class StoryFrameWidget extends StatefulWidget {
  final String numbersOfLikes;
  final String numbersOfComments;
  final Widget userPost;
  final int postLength;
  final int selectPage;

  const StoryFrameWidget(
      {super.key,
      required this.numbersOfComments,
      required this.numbersOfLikes,
      required this.userPost,
      required this.postLength,
      required this.selectPage});

  @override
  State<StoryFrameWidget> createState() => _StoryFrameWidgetState();
}

class _StoryFrameWidgetState extends State<StoryFrameWidget> {
  bool _isLiked = false;

  void onPressFavorite() {
    final LoginController lc = Get.put(LoginController());
    if (!lc.isLogin) {
      showDialog(context: context, builder: (context) => const LoginDialog());
      return;
    }
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          widget.userPost,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.person,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '익명',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  )
                ]),
          ),
          if (widget.postLength >= 2)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.bottomCenter,
                  child: PageViewDotIndicator(
                    currentItem: widget.selectPage,
                    count: widget.postLength,
                    fadeEdges: true,
                    size: Size(10, 10),
                    unselectedColor: Colors.grey,
                    selectedColor: Colors.greenAccent,
                    duration: Duration(milliseconds: 300),
                    boxShape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.bottomRight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconButton(
                        icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : Colors.white,
                        number: widget.numbersOfLikes,
                        onPressed: onPressFavorite),
                    CommentSheetButton(
                        numbersOfComments: widget.numbersOfComments),
                  ]),
            ),
          )
        ],
      ),
    );
    ;
  }
}
