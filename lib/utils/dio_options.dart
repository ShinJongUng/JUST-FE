import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioOptions {
  var options = BaseOptions(
    baseUrl: dotenv.env['API_URL']!,
  );
  BaseOptions get getOptions => options;
}
