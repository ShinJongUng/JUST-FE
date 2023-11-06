import 'package:flutter/material.dart';
import 'package:just/views/widgets/story_page/story_comments/comment_sheet_modal.dart';
import 'package:just/views/widgets/story_page/icon_button.dart';

class CommentSheetButton extends StatefulWidget {
  final int numbersOfComments;
  final int postId;
  const CommentSheetButton(
      {super.key, required this.numbersOfComments, required this.postId});

  @override
  State<CommentSheetButton> createState() => _CommentSheetButtonState();
}

class _CommentSheetButtonState extends State<CommentSheetButton> {
  late int commentsCount;

  @override
  void initState() {
    super.initState();
    commentsCount = widget.numbersOfComments;
  }

  @override
  Widget build(BuildContext context) {
    void increaseCommentCount() {
      setState(() {
        commentsCount++;
      });
    }

    DraggableScrollableController draggableScrollableController =
        DraggableScrollableController();
    return CustomIconButton(
        icon: Icons.chat_bubble_outline,
        number: commentsCount,
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                controller: draggableScrollableController,
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 0.8,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return CommentSheetModal(
                      increaseCommentCount: increaseCommentCount,
                      postId: widget.postId,
                      scrollController: scrollController,
                      draggableScrollableController:
                          draggableScrollableController);
                },
              );
            },
          );
        });
  }
}
