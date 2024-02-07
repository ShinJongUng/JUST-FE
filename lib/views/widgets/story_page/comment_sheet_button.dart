import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/post_controller.dart';
import 'package:just/views/widgets/story_page/story_comments/comment_sheet_modal.dart';
import 'package:just/views/widgets/story_page/icon_button.dart';

class CommentSheetButton extends StatefulWidget {
  final int numbersOfComments;
  final int postId;
  final String storyType;
  const CommentSheetButton(
      {super.key,
      required this.numbersOfComments,
      required this.postId,
      required this.storyType});

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
      if (widget.storyType == "single") {
        setState(() {
          commentsCount++;
        });
      } else {
        final PostController pc = Get.find();
        pc.increaseCommentCount(widget.postId);
      }
    }

    DraggableScrollableController draggableScrollableController =
        DraggableScrollableController();
    return CustomIconButton(
        icon: Icons.chat_bubble_outline,
        number: widget.storyType == "single"
            ? commentsCount
            : widget.numbersOfComments,
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
