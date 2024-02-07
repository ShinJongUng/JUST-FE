import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/getX/post_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});
  static final storage = FlutterSecureStorage();

  void _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('platform', 'none');
    try {
      await storage.delete(key: 'access-token');
      await storage.delete(key: 'refresh-token');
    } catch (e) {
      print(e);
    }

    final LoginController lc = Get.find();
    final PostController pc = Get.find();

    lc.logout();
    pc.refreshPosts();
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
            child: const Text("취소"),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: Text("로그아웃"),
            textStyle: const TextStyle(color: Colors.red),
            onPressed: () {
              _logout(context);
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
