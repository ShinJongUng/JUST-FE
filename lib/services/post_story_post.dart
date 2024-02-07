import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> postStoryPost(
    List<String> postContent, int postPictureId) async {
  try {
    final Dio dio = DioClient().dio;
    final response = await dio.post('/post/post', data: {
      "post_tag": "일상",
      "post_category": "일상",
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
