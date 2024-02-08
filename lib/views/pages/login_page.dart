import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
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
                LoginController lc = Get.find();

                lc.signInWithKakao();
              },
              child: Image.asset(
                'assets/kakao_login_large_wide.png',
                width: MediaQuery.of(context).size.width * 0.8,
              )),
          const SizedBox(height: 16.0),
          TextButton(
              onPressed: () {},
              child: Text(
                '로그인 하는데에 문제가 있나요?',
                style: TextStyle(
                    fontSize: 12, decoration: TextDecoration.underline),
              ))
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
  }
}
