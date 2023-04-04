import 'package:flutter/material.dart';
import 'package:just/views/widgets/story_page/story_comments/comment_sheet_modal.dart';
import 'package:just/views/widgets/story_page/icon_button.dart';

class CommentSheetButton extends StatelessWidget {
  final String numbersOfComments;
  const CommentSheetButton({super.key, required this.numbersOfComments});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
        icon: Icons.chat_bubble_outline,
        number: numbersOfComments,
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 0.8,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return CommentSheetModal(scrollController: scrollController);
                },
              );
            },
          );
        });
  }
}
