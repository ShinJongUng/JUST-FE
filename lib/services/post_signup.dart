import 'package:dio/dio.dart';
import 'package:just/utils/dio_options.dart';

Future<Response?> postAppleSignup(String token, String nickname) async {
  try {
    final dio = Dio(DioOptions().options);
    final response = await dio.post('/api/apple/signup', queryParameters: {
      'idToken': token,
      'nickName': nickname,
    });
    return response;
  } catch (e) {
    return null;
  }
}

Future<Response?> postKakaoSignup(String token, String nickname) async {
  try {
    final dio = Dio(DioOptions().options);
    final response = await dio.post('/api/kakao/signup', queryParameters: {
      'accessToken': token,
      'nickName': nickname,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
