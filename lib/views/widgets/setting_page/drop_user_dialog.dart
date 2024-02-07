import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/services/post_drop_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DropUserDialog extends StatelessWidget {
  const DropUserDialog({super.key});
  static final storage = const FlutterSecureStorage();

  void _dropUser(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('platform', 'none');
    try {
      await storage.delete(key: 'access-token');
      await storage.delete(key: 'refresh-token');
      await postDropUser();
    } catch (e) {
      print(e);
    }

    final LoginController lc = Get.find();
    lc.logout();
    Get.offAllNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text("회원 탈퇴"),
        content: const Text("회원 탈퇴를 하시겠습니까? 회원 탈퇴 시 모든 정보가 삭제됩니다."),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("취소"),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: const Text("탈퇴하기"),
            textStyle: const TextStyle(color: Colors.red),
            onPressed: () {
              _dropUser(context);
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text("회원 탈퇴"),
        content: const Text("회원 탈퇴를 하시겠습니까? 회원 탈퇴 시 모든 정보가 삭제됩니다."),
        actions: <Widget>[
          TextButton(
              child: const Text(
                "탈퇴하기",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _dropUser(context);
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
