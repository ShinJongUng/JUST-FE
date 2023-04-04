import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  var isLogin = false;
  String accessToken = '';
  login() => isLogin = true;
  logout() => isLogin = false;
  registerAccessToken(token) => accessToken = token;
}
