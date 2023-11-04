import 'package:get/get.dart' as Get;
import 'package:just/getX/login_controller.dart';
import 'package:just/utils/dio_options.dart';
import 'package:dio/dio.dart';

Future<Response?> postStoryPost(
    List<String> postContent, int postPictureId) async {
  try {
    final dio = Dio(DioOptions().options);
    final LoginController lc = Get.Get.put(LoginController());
    dio.options.headers["authorization"] = "Bearer ${lc.accessToken}";
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
