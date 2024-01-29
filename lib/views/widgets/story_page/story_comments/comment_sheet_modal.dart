import 'package:flutter/material.dart';
import 'package:just/models/comment_model.dart';
import 'package:just/services/get_comments.dart'; // Make sure this import is correct
import 'package:just/views/widgets/story_page/story_comments/comment_list.dart';
import 'package:just/views/widgets/story_page/story_comments/comment_sheet_header.dart';
import 'package:just/views/widgets/story_page/story_comments/comment_textfield.dart';

class CommentSheetModal extends StatefulWidget {
  final ScrollController scrollController;
  final DraggableScrollableController draggableScrollableController;
  final int postId;
  final Function increaseCommentCount;

  const CommentSheetModal({
    super.key,
    required this.scrollController,
    required this.draggableScrollableController,
    required this.postId,
    required this.increaseCommentCount,
  });

  @override
  State<CommentSheetModal> createState() => _CommentSheetModalState();
}

class _CommentSheetModalState extends State<CommentSheetModal> {
  Future<List<Comment>>? commentsFuture;
  int selectedCommentId = -1;

  @override
  void initState() {
    super.initState();
    commentsFuture = getComments(widget.postId);
  }

  void changeSelectedCommentId(int commentId) {
    setState(() {
      selectedCommentId = commentId;
    });
  }

  void refreshComments() async {
    setState(() {
      commentsFuture = getComments(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CommentSheetHeader(),
                FutureBuilder<List<Comment>>(
                  future: commentsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      )));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Expanded(
                            child: ListView(
                          controller: widget.scrollController,
                          physics: const ClampingScrollPhysics(),
                          children: const [
                            SizedBox(
                              height: 40,
                            ),
                            Center(child: Text('댓글이 없어요.')),
                          ],
                        ));
                      }
                      return CommentList(
                        changeSelectedCommentId: changeSelectedCommentId,
                        selectedCommentId: selectedCommentId,
                        comments: snapshot.data!,
                        scrollController: widget.scrollController,
                      );
                    } else {
                      return const Text('댓글이 없어요.');
                    }
                  },
                ),
                CommentTextField(
                    changeSelectedCommentId: changeSelectedCommentId,
                    selectedCommentId: selectedCommentId,
                    onRefreshComments: refreshComments,
                    postId: widget.postId,
                    draggableScrollableController:
                        widget.draggableScrollableController,
                    increaseCommentCount: widget.increaseCommentCount),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
