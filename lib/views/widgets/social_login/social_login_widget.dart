import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just/utils/dio_options.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

import '../utils/show_toast.dart';

enum LoginPlatform {
  kakao,
  apple,
  none, // logout
}

class Arguments {
  final String token;
  final String platform;

  Arguments(this.token, this.platform);
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
      final dio = Dio(DioOptions().options);

      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      final response = await dio.post('/api/kakao/login', queryParameters: {
        'accessToken': token.accessToken,
      });
      if (response.data == '/api/kakao/signup') {
        Navigator.pushNamed(context, '/sign-up',
            arguments: Arguments(token.accessToken, 'kakao'));
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('platform', 'kakao');
        await prefs.setString('access-token', response.data['access_token']);
        await prefs.setString('refresh-token', response.data['refresh_token']);
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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

  void signInWithApple() async {
    try {
      final dio = Dio(DioOptions().options);
      if (await SignInWithApple.isAvailable()) {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        final response = await dio.post('/api/apple/login', queryParameters: {
          'idToken': credential.identityToken,
        });
        if (response.data == '/api/apple/signup') {
          Navigator.pushNamed(context, '/sign-up',
              arguments: Arguments(credential.identityToken!, 'apple'));
        } else {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('platform', 'apple');
          await prefs.setString('access-token', response.data['access_token']);
          await prefs.setString(
              'refresh-token', response.data['refresh_token']);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
      ),
    );
  }
}
