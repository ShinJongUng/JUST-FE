class Comment {
  final int commentId;
  final String username;
  final DateTime timestamp;
  final String text;
  final List<Comment>? replies;

  Comment({
    required this.commentId,
    required this.username,
    required this.timestamp,
    required this.text,
    this.replies,
  });
}
