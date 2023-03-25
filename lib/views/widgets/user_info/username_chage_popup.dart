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
      title: Text('닉네임 변경'),
      content: TextField(
        controller: _nicknameController,
        decoration: InputDecoration(
          labelText: '새로운 닉네임을 입력해주세요.',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            final newNickname = _nicknameController.text;
            widget.changeUsernameState(newNickname);
            // TODO: 새로운 닉네임을 서버에 전송하고 저장하는 로직을 작성합니다.
            Navigator.pop(context);
          },
          child: Text('변경'),
        ),
      ],
    );
  }
}
