import 'package:just/models/post_with_comment_model.dart';
import 'package:just/services/dio_client.dart';

Future<List<PostWithComment>> getMyCommentPosts() async {
  try {
    final dio = DioClient().dio;

    final response = await dio.get('/get/member/comment');
    if (response.statusCode == 200) {
      final posts = (response.data as List)
          .map((item) => PostWithComment.fromJson(item))
          .toList();
      return posts;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}
