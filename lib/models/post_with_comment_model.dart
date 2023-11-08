import 'package:just/models/post_model.dart';

class PostWithComment {
  final Post post;
  final int commentId;
  final String commentContent;
  final String commentTime;

  PostWithComment({
    required this.post,
    required this.commentId,
    required this.commentContent,
    required this.commentTime,
  });

  factory PostWithComment.fromJson(Map<String, dynamic> json) {
    return PostWithComment(
      post: Post.fromJson(json['post']), // Post 객체로 변환
      commentId: json['comment_id'],
      commentContent: json['comment_content'],
      commentTime: json['time'],
    );
  }
}
