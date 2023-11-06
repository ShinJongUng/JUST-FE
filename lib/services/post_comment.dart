import 'package:get/get.dart' as Get;
import 'package:just/getX/login_controller.dart';
import 'package:just/utils/dio_options.dart';
import 'package:dio/dio.dart';

Future<Response?> postComment(
    int postId, String comment, int parentCommentId) async {
  try {
    final dio = Dio(DioOptions().options);
    final LoginController lc = Get.Get.put(LoginController());
    dio.options.headers["authorization"] = "Bearer ${lc.accessToken}";
    final response = await dio.post('/post/$postId/comments', data: {
      "comment_content": comment,
      "parent_comment_id": parentCommentId,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
