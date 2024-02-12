import 'package:flutter/material.dart';
import 'package:just/models/story_comment_model.dart';
import 'package:just/views/widgets/story_page/story_comments/comment.dart';

class CommentList extends StatelessWidget {
  final List<StoryComment> comments;
  final ScrollController scrollController;
  final int selectedCommentId;
  final Function changeSelectedCommentId;

  const CommentList(
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
