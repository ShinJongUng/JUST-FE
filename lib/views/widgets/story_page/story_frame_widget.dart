import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/getX/post_controller.dart';
import 'package:just/services/post_post_like.dart';
import 'package:just/views/widgets/story_page/comment_sheet_button.dart';
import 'package:just/views/widgets/story_page/icon_button.dart';
import 'package:just/views/widgets/utils/login_dialog.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class StoryFrameWidget extends StatefulWidget {
  final int numbersOfLikes;
  final int numbersOfComments;
  final List<String> postTags;
  final Widget userPost;
  final int postLength;
  final int selectPage;
  final int postId;
  final bool isLike;
  final String storyType;

  const StoryFrameWidget(
      {super.key,
      required this.storyType,
      required this.isLike,
      required this.numbersOfComments,
      required this.numbersOfLikes,
      required this.postTags,
      required this.userPost,
      required this.postLength,
      required this.selectPage,
      required this.postId});

  @override
  State<StoryFrameWidget> createState() => _StoryFrameWidgetState();
}

class _StoryFrameWidgetState extends State<StoryFrameWidget> {
  late bool _isLiked = false;
  late int likeCount = 0;
  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLike;
    likeCount = widget.numbersOfLikes;
  }

  void onPressFavorite() async {
    final LoginController lc = Get.find();
    final PostController pc = Get.find();

    if (!lc.isLogin) {
      showDialog(context: context, builder: (context) => const LoginDialog());
      return;
    }
    if (widget.storyType == "single") {
      await postPostLike(widget.postId, _isLiked);
      if (_isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      setState(() {
        _isLiked = !_isLiked;
      });
    } else {
      pc.toggleLike(widget.postId, !widget.isLike);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          widget.userPost,
          IgnorePointer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.selectPage != 0
                        ? Icon(
                            Icons.chevron_left,
                            size: 40,
                            color: Colors.white.withOpacity(0.5),
                          )
                        : const SizedBox(),
                    widget.selectPage != widget.postLength - 1
                        ? Icon(
                            Icons.chevron_right,
                            size: 40,
                            color: Colors.white.withOpacity(0.5),
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        widget.postTags.map((e) => '#$e').join(" "),
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
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
                    size: const Size(10, 10),
                    unselectedColor: Colors.grey,
                    selectedColor: Colors.greenAccent,
                    duration: const Duration(milliseconds: 100),
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
                        icon: widget.storyType == "single"
                            ? _isLiked
                                ? Icons.favorite
                                : Icons.favorite_border
                            : widget.isLike
                                ? Icons.favorite
                                : Icons.favorite_border,
                        color: widget.storyType == "single"
                            ? _isLiked
                                ? Colors.red
                                : Colors.white
                            : widget.isLike
                                ? Colors.red
                                : Colors.white,
                        number: widget.storyType == "single"
                            ? likeCount
                            : widget.numbersOfLikes,
                        onPressed: onPressFavorite),
                    CommentSheetButton(
                        storyType: widget.storyType,
                        numbersOfComments: widget.numbersOfComments,
                        postId: widget.postId),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
