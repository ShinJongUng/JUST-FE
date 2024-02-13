import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:just/models/signup_arguments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just/services/post_login.dart';
import 'package:just/views/widgets/utils/show_toast.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  var isLogin = false;
  var nickname = ''.obs;
  String accessToken = '';
  login() => isLogin = true;
  logout() => isLogin = false;
  registerAccessToken(token) => accessToken = token;
  registerNickname(name) => nickname.value = name;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<void> signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      final response = await postKakaoLogin(token.accessToken);
      if (response != null) {
        if (response.toString() == '/api/kakao/signup') {
          Get.toNamed("/signup",
              arguments: SignupArguments(token.accessToken, 'kakao'));
        } else {
          _signInService(response);
        }
      } else {
        showToast('로그인 도중 문제가 발생하였습니다.');
      }
    } catch (error) {
      if (error.runtimeType == PlatformException) {
        PlatformException? exception = error as PlatformException;
        if (exception.code == 'NotSupportError') {
          showToast('카카오톡 앱 로그인 이후 사용 부탁드립니다.');
        } else if (exception.code != 'CANCELED') {
          showToast('로그인 과정 중 오류가 발생했습니다.');
        }
      } else {
        showToast('로그인 과정 중 오류가 발생했습니다.');
      }
    }
  }

  Future<void> signInWithApple() async {
    try {
      if (await SignInWithApple.isAvailable()) {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        final response = await postAppleLogin(credential.identityToken!);
        if (response != null) {
          if (response.data == '/api/apple/signup') {
            Get.toNamed("/signup",
                arguments: SignupArguments(credential.identityToken!, 'apple'));
          } else {
            _signInService(response);
          }
        } else {
          showToast('로그인 도중 문제가 발생하였습니다.');
        }
      } else {
        showToast('Apple 로그인을 지원하지 않는 기기입니다.');
      }
    } catch (error) {
      if (error.runtimeType == SignInWithAppleAuthorizationException) {
        SignInWithAppleAuthorizationException? exception =
            error as SignInWithAppleAuthorizationException;
        if (exception.code != AuthorizationErrorCode.canceled) {
          showToast('로그인 과정 중 오류가 발생했습니다.');
        }
      } else {
        showToast('로그인 과정 중 오류가 발생했습니다.');
      }
    }
  }

  Future<void> _signInService(dynamic response) async {
    try {
      final accessToken = response.headers['authorization']?[0].split(' ')[1];
      final refreshToken = response.headers['refresh_token']?[0];

      if (accessToken.isNotEmpty || refreshToken.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('platform', 'kakao');
        await prefs.setString('nick-name', response.data['nickname']);
        await storage.write(key: 'access-token', value: accessToken);
        await storage.write(key: 'refresh-token', value: refreshToken);

        login();
        registerNickname(response.data['nickname']);
        registerAccessToken(accessToken);

        Get.offAllNamed('/');
      }
    } catch (e) {
      showToast('로그인 도중 문제가 발생하였습니다.');
    }
  }
}
