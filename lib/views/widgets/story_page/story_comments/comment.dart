import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/models/story_comment_model.dart';

class CommentWidget extends StatefulWidget {
  final StoryComment comment;
  final int selectedCommentId;
  final bool isReply;
  final Function changeSelectedCommentId;

  const CommentWidget(
      {Key? key,
      required this.comment,
      required this.selectedCommentId,
      required this.changeSelectedCommentId,
      this.isReply = false})
      : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  LoginController lc = Get.find();

  void pressedReplyButton() {
    if (!lc.isLogin) {
      return;
    }
    widget.changeSelectedCommentId(widget.comment.commentId);
  }

  void pressedCommentMoreButton() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.selectedCommentId == widget.comment.commentId
          ? Colors.black
          : null,
      child: Padding(
        padding: EdgeInsets.only(top: 22.0, left: widget.isReply ? 28.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                            text: '익명 ',
                            children: [
                              TextSpan(
                                  text:
                                      '${widget.comment.timestamp.year}.${widget.comment.timestamp.month}.${widget.comment.timestamp.day}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 11)),
                            ],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 4.0),
                      Text(widget.comment.text),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: pressedCommentMoreButton,
                    icon: const Icon(
                      Icons.more_vert,
                      size: 16,
                    ))
              ],
            ),
            if (widget.comment.replies != null)
              ...widget.comment.replies!.map((reply) {
                return CommentWidget(
                  changeSelectedCommentId: widget.changeSelectedCommentId,
                  comment: reply,
                  selectedCommentId: widget.selectedCommentId,
                  isReply: true,
                );
              }).toList(),
            if (!widget.isReply)
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: ElevatedButton(
                    onPressed: pressedReplyButton, child: const Text('답글 달기')),
              )
          ],
        ),
      ),
    );
  }
}
