class StoryComment {
  final int commentId;
  final String username;
  final DateTime timestamp;
  final String text;
  final int commentLike;
  final int commentDislike;
  final int blamedCount;
  final bool isMine;
  final List<StoryComment>? replies;

  StoryComment({
    required this.commentId,
    required this.username,
    required this.timestamp,
    required this.text,
    required this.commentLike,
    required this.commentDislike,
    required this.blamedCount,
    required this.isMine,
    this.replies,
  });

  factory StoryComment.fromJson(Map<String, dynamic> json) {
    return StoryComment(
      commentId: json['comment_id'],
      username: '익명',
      timestamp: DateTime.parse(json['comment_create_time']),
      text: json['comment_content'],
      commentLike: json['comment_like'],
      commentDislike: json['comment_dislike'],
      blamedCount: json['blamed_count'],
      isMine: json['isMine'],
      replies: json['child'] != null
          ? List<StoryComment>.from(
              json['child'].map((x) => StoryComment.fromJson(x)))
          : null,
    );
  }
}
