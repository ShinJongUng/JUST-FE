import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as Get;
import 'package:just/getX/login_controller.dart';
import 'package:just/getX/post_controller.dart';
import 'package:just/models/login_model.dart';
import 'package:just/services/post_login.dart';
import 'package:just/views/widgets/utils/show_toast.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    void signInService(Response<dynamic> response) async {
      try {
        final accessToken =
            response.headers['authorization']?[0].toString().split(' ')[1];
        final refreshToken = response.headers['refresh_token']?[0].toString();

        if (accessToken!.isNotEmpty || refreshToken!.isNotEmpty) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('platform', 'kakao');
          await prefs.setString('nick-name', response.data['nickname']);
          await storage.write(key: 'access-token', value: accessToken);
          await storage.write(key: 'refresh-token', value: refreshToken);
        }

        final LoginController lc = Get.Get.put(LoginController());
        final PostController pc = Get.Get.put(PostController());

        lc.login();
        lc.nickname = response.data['nickname'];
        lc.accessToken = accessToken;
        pc.refreshPosts();
        Get.Get.offAllNamed('/');
      } catch (e) {
        print(e);
        showToast('로그인 도중 문제가 발생하였습니다.');
      }
    }

    void signInWithKakao(BuildContext context) async {
      if (!context.mounted) return;
      try {
        bool isInstalled = await isKakaoTalkInstalled();
        OAuthToken token = isInstalled
            ? await UserApi.instance.loginWithKakaoTalk()
            : await UserApi.instance.loginWithKakaoAccount();
        final response = await postKakaoLogin(token.accessToken);
        if (response != null) {
          if (response.toString() == '/api/kakao/signup') {
            Get.Get.toNamed("/signup",
                arguments: LoginArguments(token.accessToken, 'kakao'));
          } else {
            signInService(response);
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
          if (response != null) {
            if (response.data == '/api/apple/signup') {
              Get.Get.toNamed("/signup",
                  arguments:
                      LoginArguments(credential.identityToken!, 'apple'));
            } else {
              signInService(response);
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

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'JUST',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Center(
            child: Text(
              '대화가 필요할 때, JUST',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 120.0),
          GestureDetector(
              onTap: () {
                signInWithKakao(context);
              },
              child: Image.asset(
                'assets/kakao_login_large_wide.png',
                width: MediaQuery.of(context).size.width * 0.8,
              )),
          const SizedBox(height: 16.0),
          // if (Platform.isIOS)
          //   ElevatedButton(
          //     onPressed: () {
          //       signInWithApple(context);
          //     },
          //     child: const Text('Apple로 로그인'),
          //   ),
        ],
      ),
    );
    ;
  }
}
