
import 'package:flutter/material.dart';

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
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            final newNickname = _nicknameController.text;
            widget.changeUsernameState(newNickname);
            Navigator.pop(context);
          },
          child: const Text('변경'),
        ),
      ],
    );
  }
}
