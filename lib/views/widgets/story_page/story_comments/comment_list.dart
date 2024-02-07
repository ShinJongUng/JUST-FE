import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/models/comment_model.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  int selectedCommentId;
  final bool isReply;
  Function changeSelectedCommentId;

  CommentWidget(
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isReply || !lc.isLogin) {
          return;
        }
        if (widget.selectedCommentId == widget.comment.commentId) {
          widget.changeSelectedCommentId(-1);
          return;
        }
        widget.changeSelectedCommentId(widget.comment.commentId);
      },
      child: Container(
        color: widget.selectedCommentId == widget.comment.commentId
            ? Colors.black38
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
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
                    const Text(
                      '익명',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(widget.comment.text),
                    const SizedBox(height: 8.0),
                    if (widget.comment.replies != null)
                      ...widget.comment.replies!.map((reply) {
                        return CommentWidget(
                          changeSelectedCommentId:
                              widget.changeSelectedCommentId,
                          comment: reply,
                          selectedCommentId: widget.selectedCommentId,
                          isReply: true,
                        );
                      }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  final List<Comment> comments;
  ScrollController scrollController;
  int selectedCommentId;
  final Function changeSelectedCommentId;

  CommentList(
      {Key? key,
      required this.comments,
      required this.scrollController,
      required this.selectedCommentId,
      required this.changeSelectedCommentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: CommentWidget(
              changeSelectedCommentId: changeSelectedCommentId,
              comment: comment,
              selectedCommentId: selectedCommentId,
            ),
          );
        },
      ),
    );
  }
}
