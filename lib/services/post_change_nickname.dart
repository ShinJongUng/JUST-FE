import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> postChangeNickname(String nickName) async {
  try {
    final Dio dio = DioClient().dio;

    final response = await dio.post('/change/nickName', queryParameters: {
      "nickname": nickName,
    });
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
