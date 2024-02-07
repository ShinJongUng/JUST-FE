import 'package:just/models/post_model.dart';
import 'package:just/services/dio_client.dart';

Future<List<Post>> getMyLikePosts() async {
  try {
    final dio = DioClient().dio;

    final response = await dio.get('/get/like/member/post');

    if (response.statusCode == 200) {
      final posts =
          (response.data as List).map((item) => Post.fromJson(item)).toList();
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
