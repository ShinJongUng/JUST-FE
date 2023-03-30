import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/views/widgets/utils/login_dialog.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({super.key});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final _textController = TextEditingController();
  bool _isTextEmpty = true;
  final LoginController lc = Get.put(LoginController());

  void onPressCommentSend() {
    _textController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isTextEmpty = true;
    });
  }

  void onTextFieldTap() {
    if (!lc.isLogin) {
      showDialog(context: context, builder: (context) => const LoginDialog());
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              SizedBox(
                child: TextFormField(
                    onTap: onTextFieldTap,
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _isTextEmpty = false;
                        } else {
                          _isTextEmpty = true;
                        }
                      });
                    },
                    cursorColor: Colors.white,
                    minLines: 1,
                    maxLines: 3,
                    controller: _textController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: lc.isLogin ? '댓글을 입력해주세요' : '로그인이 필요헌 서비스입니다.',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Colors.grey)),
                      suffixIcon: _isTextEmpty
                          ? null
                          : IconButton(
                              onPressed: onPressCommentSend,
                              icon: const Icon(
                                Icons.send,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
