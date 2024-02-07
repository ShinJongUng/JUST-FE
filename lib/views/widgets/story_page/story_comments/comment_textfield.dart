import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just/getX/login_controller.dart';
import 'package:just/services/post_comment.dart';
import 'package:just/views/widgets/utils/login_dialog.dart';

class CommentTextField extends StatefulWidget {
  final DraggableScrollableController draggableScrollableController;
  final int postId;
  final Function onRefreshComments;
  final Function increaseCommentCount;
  final int selectedCommentId;
  final Function changeSelectedCommentId;

  const CommentTextField(
      {super.key,
      required this.draggableScrollableController,
      required this.changeSelectedCommentId,
      required this.selectedCommentId,
      required this.postId,
      required this.onRefreshComments,
      required this.increaseCommentCount});

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final _textController = TextEditingController();
  bool _isTextEmpty = true;
  final LoginController lc = Get.find();

  void onPressCommentSend() async {
    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(status: '댓글 작성중...');
    final response = await postComment(widget.postId, _textController.text,
        widget.selectedCommentId == -1 ? 0 : widget.selectedCommentId);
    if (response?.statusCode != 200) {
      EasyLoading.showError('댓글 작성 실패!');
      return;
    }
    _textController.clear();
    setState(() {
      _isTextEmpty = true;
    });
    widget.increaseCommentCount();
    await widget.onRefreshComments();
    widget.changeSelectedCommentId(-1);
    EasyLoading.showSuccess('댓글 작성 완료!');
  }

  void onTextFieldTap() {
    if (!lc.isLogin) {
      showDialog(context: context, builder: (context) => const LoginDialog());
      return;
    } else {
      //widget.draggableScrollableController
      widget.draggableScrollableController.animateTo(1,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
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
                      hintText: lc.isLogin ? '댓글을 입력해주세요' : '로그인이 필요한 서비스입니다.',
                      enabled: lc.isLogin ? true : false,
                      border: OutlineInputBorder(
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
