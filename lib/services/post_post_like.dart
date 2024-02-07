import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> postPostLike(int postId, bool isLike) async {
  try {
    final Dio dio = DioClient().dio;

    final response = await dio.post('/post/like', queryParameters: {
      "post_id": postId,
      "like": isLike,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
