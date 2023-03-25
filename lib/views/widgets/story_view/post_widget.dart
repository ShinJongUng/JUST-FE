import 'package:flutter/material.dart';
import 'package:just/views/widgets/story_view/comment_sheet_button.dart';
import 'package:just/views/widgets/story_view/icon_button.dart';

class PostWidget extends StatefulWidget {
  final String numbersOfLikes;
  final String numbersOfComments;
  final Widget userPost;

  const PostWidget(
      {super.key,
      required this.numbersOfComments,
      required this.numbersOfLikes,
      required this.userPost});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;

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
                        onPressed: () {
                          setState(() {
                            _isLiked = !_isLiked;
                          });
                        }),
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
