import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> deleteStoryPost(int postId) async {
  try {
    final Dio dio = DioClient().dio;
    final response = await dio.get('/delete/post', queryParameters: {
      "post_id": postId,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
