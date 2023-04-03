import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text("로그인이 필요한 서비스입니다."),
        content: Text("로그인 하시겠습니까?"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("확인"),
            onPressed: () {
              Get.back();
              Get.toNamed('/login');
            },
          ),
          CupertinoDialogAction(
            child: Text("취소"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text("로그인이 필요한 서비스입니다."),
        content: Text("로그인 하시겠습니까?"),
        actions: <Widget>[
          TextButton(
            child: Text("확인"),
            onPressed: () {
              Get.toNamed('/login');
            },
          ),
          TextButton(
            child: Text("취소"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    }
  }
}
