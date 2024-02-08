class Post {
  final int postId;
  final List<String> postHashTag;
  final int postPicture;
  final String postCreateTime;
  final bool secret;
  int commentCount = 0;
  int likeCount = 0;
  final int blamedCount;
  final List<String> postContents;
  bool like = false;

  Post({
    required this.postId,
    required this.postHashTag,
    required this.postPicture,
    required this.postCreateTime,
    required this.secret,
    required this.commentCount,
    required this.likeCount,
    required this.blamedCount,
    required this.postContents,
    this.like = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['post_id'],
      postHashTag: json['hash_tag'].cast<String>() ?? [],
      postPicture: json['post_picture'],
      postCreateTime: json['post_create_time'],
      secret: json['secret'],
      postContents: json['post_content'].cast<String>(),
      commentCount: json['comment_size'],
      likeCount: json['post_like_size'],
      blamedCount: json['blamed_count'],
      like: json['like'] ?? false,
    );
  }
}

class PostsResponse {
  final List<Post> mySlice;
  final bool hasNext;

  PostsResponse({
    required this.mySlice,
    required this.hasNext,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['mySlice'] as List;
    List<Post> postsList = list.map((i) => Post.fromJson(i)).toList();
    return PostsResponse(
      mySlice: postsList,
      hasNext: json['hasNext'],
    );
  }
}
