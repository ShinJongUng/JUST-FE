import 'package:get/get.dart' as Get;
import 'package:just/getX/login_controller.dart';
import 'package:just/utils/dio_options.dart';
import 'package:dio/dio.dart';

Future<Response?> postPostLike(int postId, bool isLike) async {
  try {
    final dio = Dio(DioOptions().options);
    final LoginController lc = Get.Get.put(LoginController());
    dio.options.headers["authorization"] = "Bearer ${lc.accessToken}";
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
