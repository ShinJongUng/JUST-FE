import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> putStoryPost(int postId, List<String> postContent,
    int postPictureId, List<String> tags) async {
  try {
    final Dio dio = DioClient().dio;
    final response = await dio.put('/put/post', data: {
      "post_id": postId,
      "hash_tage": tags,
      "post_content": postContent,
      "post_picture": postPictureId,
      "secret": true
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
