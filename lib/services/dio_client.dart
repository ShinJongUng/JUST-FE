import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';

const excludedPaths = [
  '/apple/signup,',
  '/kakao/signup',
  '/kakao/login',
  '/apple/login',
  '/get/post'
];

//Dio Singleton
class DioClient {
  static final DioClient _singleton = DioClient._internal();

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: "${dotenv.env['API_URL']!}/api",
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (!excludedPaths.contains(options.path)) {
          final LoginController lc = Get.find();
          if (lc.isLogin && lc.accessToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer ${lc.accessToken}";
          }
        }

        return handler.next(options);
      },
    ));
  }

  late Dio _dio;

  Dio get dio => _dio;
}
