import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/services/post_change_nickname.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsernameChangePopup extends StatefulWidget {
  const UsernameChangePopup({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UsernameChangePopupState createState() => _UsernameChangePopupState();
}

class _UsernameChangePopupState extends State<UsernameChangePopup> {
  final TextEditingController _nicknameController = TextEditingController();
  final LoginController lc = Get.find();
  String errorText = '';

  @override
  void initState() {
    super.initState();
    _nicknameController.text = lc.nickname.value;
  }

  void pressedChangeButton() {
    final newNickname = _nicknameController.text;
    changeUsernameState(newNickname);
  }

  void pressedCancelButton() {
    Get.back();
  }

  void changeUsernameState(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (lc.nickname == value) return;
    if (value.isEmpty) {
      setState(() {
        errorText = '닉네임을 입력하세요.';
      });
      return;
    } else if (value.length < 3 || value.length > 10) {
      setState(() {
        errorText = '3글자 이상 10글자 이하로 입력해주세요.';
      });
    } else if (!RegExp(r'^[a-zA-Z가-힣_]*[a-zA-Z가-힣][a-zA-Z가-힣_]*$')
        .hasMatch(value)) {
      setState(() {
        errorText = '닉네임은 한글, 영어, 숫자만 입력 가능합니다.';
      });
    } else {
      EasyLoading.show(status: '닉네임 변경 중...');
      final response = await postChangeNickname(value);
      if (response?.statusCode != 200) {
        EasyLoading.showError('닉네임 변경 실패! 잠시후 다시 시도해주세요.');
        Get.back();
        return;
      }
      setState(() {
        lc.nickname.value = value;
        errorText = '';
      });
      prefs.setString('nick-name', value);
      EasyLoading.showSuccess('닉네임 변경 완료!');
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text('닉네임 변경'),
        content: CupertinoTextField(
          style: const TextStyle(
            color: Colors.white,
          ),
          controller: _nicknameController,
          placeholder: '새로운 닉네임을 입력해주세요.',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: pressedCancelButton,
            child: const Text('취소'),
          ),
          CupertinoDialogAction(
            onPressed: pressedChangeButton,
            child: const Text('변경'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('닉네임 변경'),
        content: TextField(
          controller: _nicknameController,
          decoration: InputDecoration(
              labelText: '새로운 닉네임을 입력해주세요.',
              errorText: errorText.isEmpty ? null : errorText),
        ),
        actions: [
          TextButton(
            onPressed: pressedCancelButton,
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: pressedChangeButton,
            child: const Text('변경'),
          ),
        ],
      );
    }
  }
}
