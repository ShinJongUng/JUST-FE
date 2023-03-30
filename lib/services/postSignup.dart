import 'package:dio/dio.dart';
import 'package:just/utils/dio_options.dart';

Future<Response> postAppleSignup(String token, String nickname) async {
  final dio = Dio(DioOptions().options);
  final response = await dio.post('/api/kakao/signup', queryParameters: {
    'accessToken': token,
    'nickName': nickname,
  });
  return response;
}

Future<Response> postKakaoSignup(String token, String nickname) async {
  final dio = Dio(DioOptions().options);
  final response = await dio.post('/api/kakao/signup', queryParameters: {
    'accessToken': token,
    'nickName': nickname,
  });
  return response;
}
