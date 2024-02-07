import 'package:just/services/dio_client.dart';
import 'package:dio/dio.dart';

Future<Response?> postDropUser() async {
  try {
    final Dio dio = DioClient().dio;
    final response = await dio.post('/drop');
    return response;
  } catch (e) {
    print(e);
    return null;
  }
}
