import 'package:flutter/material.dart';
import 'package:just/models/login_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          const SizedBox(height: 64.0),
          ElevatedButton(
            onPressed: () {
              signInWithKakao(context);
            },
            child: const Text('카카오톡으로 로그인'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              signInWithApple(context);
            },
            child: const Text('Apple로 로그인'),
          ),
        ],
      ),
    );
    ;
  }
}
