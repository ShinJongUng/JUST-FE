class PostArguments {
  final int numbersOfComments;
  final int numbersOfLikes;
  final int bgImageId;
  final List<String> pagesText;
  final List<String> postTags;
  final int postId;
  final bool like;

  PostArguments(
      {required this.numbersOfComments,
      required this.numbersOfLikes,
      required this.bgImageId,
      required this.pagesText,
      required this.postTags,
      required this.postId,
      required this.like});

  factory PostArguments.fromJson(Map<String, dynamic> json) {
    return PostArguments(
      postId: json['postId'],
      postTags: List<String>.from(json['postTags']),
      numbersOfComments: json['numbersOfComments'],
      numbersOfLikes: json['numbersOfLikes'],
      bgImageId: json['bgImageId'],
      like: json['like'],
      pagesText: List<String>.from(json['pagesText']),
    );
  }
}
