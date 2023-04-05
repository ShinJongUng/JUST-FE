import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/utils/dio_options.dart';

Future<dynamic?> postStoryPost(String postContent) async {
  try {
    final dio = Dio(DioOptions().options);
    final LoginController lc = Get.put(LoginController());
    dio.options.headers["access-token"] = lc.accessToken;
    final response = await dio.post('/api/post/post', data: {
      "post_tag": "post_tag",
      "post_content": postContent,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
