import 'package:flutter/material.dart';
import 'package:just/views/widgets/story_comments/comment_list.dart';
import 'package:just/views/widgets/story_comments/comment_sheet_header.dart';
import 'package:just/views/widgets/story_comments/comment_textfield.dart';

class CommentSheetModal extends StatelessWidget {
  CommentSheetModal({super.key});

  final List<Comment> comments = [
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user1',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      text: '첫 번째 댓글입니다.',
      replies: [
        Comment(
          profileImage: 'assets/test1.jpg',
          username: 'user2',
          timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
          text: '첫 번째 댓글의 첫 번째 대댓글입니다.',
        ),
        Comment(
          profileImage: 'assets/test1.jpg',
          username: 'user3',
          timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
          text: '첫 번째 댓글의 두 번째 대댓글입니다.',
        ),
      ],
    ),
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user4',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      text: '두 번째 댓글입니다.',
    ),
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user5',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      text: '세 번째 댓글입니다.',
      replies: [
        Comment(
          profileImage: 'assets/test1.jpg',
          username: 'user6',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          text: '세 번째 댓글의 첫 번째 대댓글입니다.',
        ),
      ],
    ),
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user7',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      text: '네 번째 댓글입니다.',
    ),
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user5',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      text: '세 번째 댓글입니다.',
      replies: [
        Comment(
          profileImage: 'assets/test1.jpg',
          username: 'user6',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          text: '세 번째 댓글의 첫 번째 대댓글입니다.',
        ),
      ],
    ),
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user7',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      text: '네 번째 댓글입니다.',
    ),
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user5',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      text: '세 번째 댓글입니다.',
      replies: [
        Comment(
          profileImage: 'assets/test1.jpg',
          username: 'user6',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          text: '세 번째 댓글의 첫 번째 대댓글입니다.',
        ),
      ],
    ),
    Comment(
      profileImage: 'assets/test1.jpg',
      username: 'user7',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      text: '네 번째 댓글입니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
      child: Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CommentSheetHeader(),
                  CommentList(
                    comments: comments,
                  ),
                  const CommentTextField(),
                ])),
      ]),
    );
    ;
  }
}
