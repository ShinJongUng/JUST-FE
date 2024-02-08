import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({
    super.key,
  });

  void pressedOkButton() {
    Get.back();
    Get.toNamed('/login');
  }

  void pressedCancelButton() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text("로그인이 필요한 서비스입니다."),
        content: const Text("로그인 하시겠습니까?"),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: pressedOkButton,
            child: const Text("확인"),
          ),
          CupertinoDialogAction(
            onPressed: pressedCancelButton,
            child: const Text("취소"),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text("로그인이 필요한 서비스입니다."),
        content: const Text("로그인 하시겠습니까?"),
        actions: <Widget>[
          TextButton(onPressed: pressedOkButton, child: const Text("확인")),
          TextButton(onPressed: pressedCancelButton, child: const Text("취소")),
        ],
      );
    }
  }
}
