import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:just/getX/login_controller.dart';
import 'package:just/services/post_login.dart';
import 'package:just/views/widgets/utils/show_toast.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginArguments {
  final String token;
  final String platform;

  LoginArguments(this.token, this.platform);
}

void signInWithKakao(BuildContext context) async {
  if (!context.mounted) return;
  try {
    bool isInstalled = await isKakaoTalkInstalled();

    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();
    final response = await postKakaoLogin(token.accessToken);
    if (response.data == '/api/kakao/signup') {
      Get.toNamed("/signup",
          arguments: LoginArguments(token.accessToken, 'kakao'));
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('platform', 'kakao');
      await prefs.setString('access-token', response.data['access_token']);
      await prefs.setString('refresh-token', response.data['refresh_token']);
      final LoginController lc = Get.put(LoginController());
      lc.login();
      Get.offAllNamed('/');
    }
  } catch (error) {
    if (error.runtimeType == PlatformException) {
      PlatformException? exception = error as PlatformException;
      if (exception.code != 'CANCELED') {
        showToast('로그인 과정 중 오류가 발생했습니다.');
      }
    } else {
      print(error);
      showToast('로그인 과정 중 오류가 발생했습니다.');
    }
  }
}

void signInWithApple(BuildContext context) async {
  if (!context.mounted) return;
  try {
    if (await SignInWithApple.isAvailable()) {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final response = await postAppleLogin(credential.identityToken!);
      if (response.data == '/api/apple/signup') {
        Get.toNamed("/signup",
            arguments: LoginArguments(credential.identityToken!, 'apple'));
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('platform', 'apple');
        await prefs.setString('access-token', response.data['access_token']);
        await prefs.setString('refresh-token', response.data['refresh_token']);
        final LoginController lc = Get.put(LoginController());
        lc.login();
        Get.offAllNamed('/');
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
      print(error);
      showToast('로그인 과정 중 오류가 발생했습니다.');
    }
  }
}
