import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> postComment(
    int postId, String comment, int parentCommentId) async {
  try {
    final Dio dio = DioClient().dio;

    final response = await dio.post('/post/$postId/comments', data: {
      "comment_content": comment,
      "parent_comment_id": parentCommentId,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
