import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;

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
      print('카카오톡으로 로그인 실패 $error');
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
          onPressed: () {
            // 애플 로그인 처리 로직
          },
          child: Text('Apple로 로그인'),
        ),
      ],
    );
  }
}
