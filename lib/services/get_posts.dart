import 'package:dio/dio.dart';
import 'package:get/get.dart' as Get;
import 'package:just/getX/login_controller.dart';
import 'package:just/models/post_model.dart';
import 'package:just/utils/dio_options.dart';

Future<PostsResponse?> getPosts(int requestPage, List<int>? viewedPosts) async {
  try {
    final dio = Dio(DioOptions().options);
    final LoginController lc = Get.Get.put(LoginController());
    if (viewedPosts!.isNotEmpty) {
      dio.options.headers["viewed"] = viewedPosts.join(",");
    }
    if (lc.isLogin && lc.accessToken.isNotEmpty) {
      dio.options.headers["Authorization"] = "Bearer ${lc.accessToken}";
    }

    final response = await dio.get(
      lc.isLogin && lc.accessToken.isNotEmpty
          ? '/get/member/post'
          : '/get/post',
      queryParameters: {'request_page': requestPage},
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
