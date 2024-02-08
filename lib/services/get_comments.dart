import 'package:just/models/story_comment_model.dart';
import 'package:just/services/dio_client.dart'; // 필요에 따라 정확한 경로로 수정

Future<List<StoryComment>> getComments(int postId) async {
  final dio = DioClient().dio;

  final response = await dio.get('/v2/get/$postId/comments');
  if (response.statusCode == 200) {
    List<dynamic> jsonComments = response.data["comments"];
    List<StoryComment> comments = [];

    for (var jsonComment in jsonComments) {
      StoryComment comment = StoryComment.fromJson(jsonComment);
      comments.add(comment);
    }

    return comments;
  } else {
    throw Exception('Comments 에러 발생');
  }
}
