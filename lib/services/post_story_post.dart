import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> postStoryPost(
    List<String> postContent, int postPictureId, List<String> tags) async {
  print(tags);
  try {
    final Dio dio = DioClient().dio;
    final response = await dio.post('/post/post', data: {
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
