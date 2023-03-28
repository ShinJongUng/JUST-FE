import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just/views/widgets/social_login/social_login_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupWidget extends StatefulWidget {
  SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Arguments arguments =
        ModalRoute.of(context)?.settings.arguments as Arguments;
    final _textController = TextEditingController();

    bool isLoading = false;
    void _pressSignUpButton() async {
      if (_formKey.currentState!.validate()) {
        isLoading = true;
        final response = await http.post(
            Uri.parse('${dotenv.env['API_URL']}/api/kakao/signup'),
            body: {
              'accessToken': arguments.token,
              'nickName': _textController.text,
            });
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final Map<String, dynamic> user_token = jsonDecode(response.body);
        await prefs.setString('platform', 'kakao');
        await prefs.setString('access-token', user_token['access_token']);
        await prefs.setString('refresh-token', user_token['refresh_token']);
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 48, 48, 48),
              shadowColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => PlatformOkCancelDialog(
                          title: '가입 취소',
                          content: '닉네임 등록을 취소하시겠습니까?',
                          okText: '예',
                          cancelText: '아니요'));
                },
              )),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Just 닉네임 등록하기',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextFormField(
                                  controller: _textController,
                                  validator: (name) {
                                    if (name!.isEmpty) {
                                      return '닉네임을 입력하세요.';
                                    } else if (name.length < 3 ||
                                        name.length > 10) {
                                      return '닉네임은 3글자 이상 10글자 이하로 입력해주세요.';
                                    } else if (RegExp(
                                            r'^[a-zA-Z0-9_\uac00-\ud7a3]*(?:[^\u3131-\u314e\u314f-\u3163\uac00-\ud7a3]|[aeiouAEIOU])*[a-zA-Z0-9_\uac00-\ud7a3]*$')
                                        .hasMatch(name)) {
                                      return '닉네임은 한글, 영어, 숫자만 입력 가능합니다.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '닉네임을 입력하세요',
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: isLoading ? () {} : _pressSignUpButton,
                        child: Text('닉네임 등록'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
    ;
  }
}
