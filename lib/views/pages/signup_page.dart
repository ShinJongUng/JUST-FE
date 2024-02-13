import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:just/getX/login_controller.dart';
import 'package:just/models/login_model.dart';
import 'package:just/services/post_signup.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';
import 'package:just/views/widgets/utils/show_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final _formKey = GlobalKey<FormState>();
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    LoginArguments arguments =
        ModalRoute.of(context)?.settings.arguments as LoginArguments;
    final _textController = TextEditingController();
    bool isLoading = false;

    void signInService(Response<dynamic> response) async {
      try {
        final accessToken =
            response.headers['authorization'].toString().split(' ')[1];
        final refreshToken = response.headers['refresh_token'].toString();
        if (accessToken.isNotEmpty || refreshToken.isNotEmpty) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('platform', 'kakao');
          await prefs.setString('nick-name', _textController.text);
          await storage.write(key: 'access-token', value: accessToken);
          await storage.write(key: 'refresh-token', value: refreshToken);
        }

        final LoginController lc = Get.Get.find();
        lc.login();
        isLoading = false;
        lc.registerNickname(_textController.text);
        lc.registerAccessToken(accessToken);

        Get.Get.offAllNamed('/');
      } catch (e) {
        showToast('회원가입 도중 문제가 발생하였습니다.');
      }
    }

    void pressSignUpButton() async {
      if (!context.mounted) return;
      if (_formKey.currentState!.validate()) {
        try {
          isLoading = true;
          if (arguments.platform == 'kakao') {
            final response =
                await postKakaoSignup(arguments.token, _textController.text);
            if (response != null) {
              signInService(response);
              Get.Get.offAllNamed('/');
            } else {
              showToast('회원가입 도중 문제가 발생하였습니다.');
              Get.Get.back();
              isLoading = false;
            }
          } else if (arguments.platform == 'apple') {
            final response =
                await postAppleSignup(arguments.token, _textController.text);
            if (response != null) {
              signInService(response);
            } else {
              showToast('회원가입 도중 문제가 발생하였습니다.');
              Get.Get.back();
              isLoading = false;
            }
          }
        } catch (e) {
          showToast('로그인 도중 문제가 발생하였습니다.');
          Get.Get.back();
          isLoading = false;
        }
      }
    }

    String? isValidate(name) {
      if (name!.isEmpty) {
        return '닉네임을 입력하세요.';
      } else if (name.length < 3 || name.length > 10) {
        return '닉네임은 3글자 이상 10글자 이하로 입력해주세요.';
      } else if (!RegExp(r'^[a-zA-Z가-힣_]*[a-zA-Z가-힣][a-zA-Z가-힣_]*$')
          .hasMatch(name)) {
        return '닉네임은 한글, 영어, 숫자만 입력 가능합니다.';
      }
      return null;
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 48, 48, 48),
              shadowColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => PlatformOkCancelDialog(
                          title: '가입 취소',
                          content: '닉네임 등록을 취소하시겠습니까?',
                          onPressedOkButton: () {
                            Get.Get.back();
                            Get.Get.back();
                          },
                          onPressedCancelButton: () {
                            Get.Get.back();
                          },
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
                                child: const Text(
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: TextFormField(
                                  controller: _textController,
                                  validator: isValidate,
                                  decoration: const InputDecoration(
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
                        onPressed: isLoading ? () {} : pressSignUpButton,
                        child: const Text('닉네임 등록'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
