import 'package:dio/dio.dart';
import 'package:just/utils/dio_options.dart';

Future<Response?> postKakaoLogin(String accessToken) async {
  try {
    final dio = Dio(DioOptions().options);
    final response = await dio.post('/api/kakao/login', queryParameters: {
      'accessToken': accessToken,
    });
    return response;
  } catch (e) {
    return null;
  }
}

Future<Response?> postAppleLogin(String idToken) async {
  try {
    final dio = Dio(DioOptions().options);
    final response = await dio.post('/api/apple/login', queryParameters: {
      'idToken': idToken,
    });
    return response;
  } catch (e) {
    return null;
  }
}
