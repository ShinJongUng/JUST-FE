import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/models/post_model.dart';
import 'package:just/services/dio_client.dart';

Future<PostsResponse?> getPosts(int requestPage, List<int>? viewedPosts) async {
  try {
    final Dio dio = DioClient().dio;
    final LoginController lc = Get.find();
    String endpoint = lc.isLogin && lc.accessToken.isNotEmpty
        ? '/get/member/post'
        : '/get/post';

    Map<String, dynamic> extraHeaders = {};
    if (viewedPosts != null && viewedPosts.isNotEmpty) {
      extraHeaders['viewed'] = viewedPosts.join(",");
    }

    final response = await dio.get(
      endpoint,
      queryParameters: {'request_page': requestPage},
      options: Options(
        headers: extraHeaders, // 'headers'를 통해 'viewed' 헤더 추가
      ),
    );

    if (response.statusCode == 200) {
      return PostsResponse.fromJson(response.data);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
