import 'package:dio/dio.dart';
import 'package:get/get.dart' as Get;
import 'package:just/getX/login_controller.dart';
import 'package:just/models/post_model.dart';
import 'package:just/utils/dio_options.dart';

Future<List<Post>> getMyPosts() async {
  try {
    final dio = Dio(DioOptions().options);
    final LoginController lc = Get.Get.put(LoginController());

    if (lc.isLogin && lc.accessToken.isNotEmpty) {
      dio.options.headers["Authorization"] = "Bearer ${lc.accessToken}";
    }

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
