import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsernameChangePopup extends StatefulWidget {
  final String currentNickname;
  final ValueChanged<String> changeUsernameState;

  const UsernameChangePopup(
      {Key? key,
      required this.currentNickname,
      required this.changeUsernameState})
      : super(key: key);

  @override
  _UsernameChangePopupState createState() => _UsernameChangePopupState();
}

class _UsernameChangePopupState extends State<UsernameChangePopup> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nicknameController.text = widget.currentNickname;
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
            onPressed: () {
              Get.back();
            },
            child: const Text('취소'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              final newNickname = _nicknameController.text;
              widget.changeUsernameState(newNickname);
              Get.back();
            },
            child: const Text('변경'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('닉네임 변경'),
        content: TextField(
          controller: _nicknameController,
          decoration: const InputDecoration(
            labelText: '새로운 닉네임을 입력해주세요.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              final newNickname = _nicknameController.text;
              widget.changeUsernameState(newNickname);
              Get.back();
            },
            child: const Text('변경'),
          ),
        ],
      );
    }
  }
}
