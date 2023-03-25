import 'package:flutter/material.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'JUST',
          style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 64.0),
        ElevatedButton(
          onPressed: () {
            // 카카오톡 로그인 처리 로직
          },
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
