import 'package:flutter/material.dart';

class Comment {
  final String profileImage;
  final String username;
  final DateTime timestamp;
  final String text;
  final List<Comment>? replies;

  Comment({
    required this.profileImage,
    required this.username,
    required this.timestamp,
    required this.text,
    this.replies,
  });
}

class CommentWidget extends StatefulWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(widget.comment.profileImage),
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
                    return CommentWidget(comment: reply);
                  }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentList extends StatelessWidget {
  final List<Comment> comments;

  const CommentList({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: CommentWidget(comment: comment),
          );
        },
      ),
    );
  }
}
