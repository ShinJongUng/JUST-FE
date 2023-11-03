import 'package:dio/dio.dart';
import 'package:just/utils/dio_options.dart';

Future<Response?> postKakaoLogin(String accessToken) async {
  try {
    final dio = Dio(DioOptions().options);
    final response = await dio.post('/kakao/login', queryParameters: {
      'access_token': accessToken,
    });
    return response;
  } catch (e) {
    return null;
  }
}

Future<Response?> postAppleLogin(String idToken) async {
  try {
    final dio = Dio(DioOptions().options);
    final response = await dio.post('/apple/login', queryParameters: {
      'id_token': idToken,
    });
    return response;
  } catch (e) {
    return null;
  }
}
