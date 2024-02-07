import 'package:just/models/post_model.dart';
import 'package:just/services/dio_client.dart';

Future<List<Post>> getMyPosts() async {
  try {
    final dio = DioClient().dio;

    final response = await dio.get('/get/mypost');

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
