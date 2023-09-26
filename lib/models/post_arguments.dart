class PostArguments {
  final int numbersOfComments;
  final int numbersOfLikes;
  final int bgImageId;
  final List<String> pagesText;

  PostArguments({
    required this.numbersOfComments,
    required this.numbersOfLikes,
    required this.bgImageId,
    required this.pagesText,
  });

  factory PostArguments.fromJson(Map<String, dynamic> json) {
    return PostArguments(
      numbersOfComments: json['numbersOfComments'],
      numbersOfLikes: json['numbersOfLikes'],
      bgImageId: json['bgImageId'],
      pagesText: List<String>.from(json['pagesText']),
    );
  }
}
