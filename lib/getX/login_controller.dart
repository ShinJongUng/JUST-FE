import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  var isLogin = false;
  login() => isLogin = true;
  logout() => isLogin = false;
}
