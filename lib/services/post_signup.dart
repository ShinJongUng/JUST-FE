import 'package:dio/dio.dart';
import 'package:just/utils/dio_options.dart';

Future<Response?> postAppleSignup(String token, String nickname) async {
  try {
    final dio = Dio(DioOptions().options);
    final response = await dio.post('/apple/signup', queryParameters: {
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
    final response = await dio.post('/kakao/signup', queryParameters: {
      'access_token': token,
      'nickname': nickname,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
