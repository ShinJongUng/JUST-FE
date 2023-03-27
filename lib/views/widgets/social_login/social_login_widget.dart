import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

import '../utils/show_toast.dart';

enum LoginPlatform {
  kakao,
  apple,
  none, // logout
}

class SocialLoginWidget extends StatefulWidget {
  SocialLoginWidget({Key? key}) : super(key: key);

  @override
  State<SocialLoginWidget> createState() => _SocialLoginWidgetState();
}

class _SocialLoginWidgetState extends State<SocialLoginWidget> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  void signInWithKakao() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      print('카카오톡으로 로그인 성공 ${token}');
    } catch (error) {
      PlatformException? exception = error as PlatformException;
      if (exception.code != 'CANCELED') {
        showToast('로그인 과정 중 오류가 발생했습니다.');
      }
    }
  }

  void signInWithApple() async {
    try {
      if (await SignInWithApple.isAvailable()) {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        print(credential);
      } else {
        showToast('Apple 로그인을 지원하지 않는 기기입니다.');
      }
    } catch (error) {
      SignInWithAppleAuthorizationException? exception =
          error as SignInWithAppleAuthorizationException;
      if (exception.code != AuthorizationErrorCode.canceled) {
        showToast('로그인 과정 중 오류가 발생했습니다.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'JUST',
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
        SizedBox(height: 64.0),
        ElevatedButton(
          onPressed: signInWithKakao,
          child: Text('카카오톡으로 로그인'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: signInWithApple,
          child: Text('Apple로 로그인'),
        ),
      ],
    );
  }
}
