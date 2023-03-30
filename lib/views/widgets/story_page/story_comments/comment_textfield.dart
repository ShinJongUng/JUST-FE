import 'package:flutter/material.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({super.key});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final _textController = TextEditingController();
  bool _isTextEmpty = true;

  void onPressCommentSend() {
    _textController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _isTextEmpty = true;
    });
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
                      hintText: '댓글을 입력해주세요',
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
