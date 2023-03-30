import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  void _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('platform', 'none');
    await prefs.remove('access-token');
    await prefs.remove('refresh-token');
    final LoginController lc = Get.put(LoginController());
    lc.logout();
    Get.offAllNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text("로그아웃"),
        content: const Text("로그아웃 하시겠습니까?"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("확인"),
            onPressed: () {
              _logout(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text("취소"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text("로그아웃"),
        content: const Text("로그아웃 하시겠습니까?"),
        actions: <Widget>[
          TextButton(
              child: const Text("확인"),
              onPressed: () {
                _logout(context);
              }),
          TextButton(
            child: const Text("취소"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    }
  }
}
