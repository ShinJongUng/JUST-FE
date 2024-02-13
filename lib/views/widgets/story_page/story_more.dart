import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:just/getX/post_write_controller.dart';
import 'package:just/models/post_arguments.dart';
import 'package:just/models/post_type_arguments.dart';
import 'package:just/services/delete_story_post.dart';
import 'package:just/views/widgets/story_page/blame_dialog.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';
import 'package:just/views/widgets/utils/show_toast.dart';

class StoryMore extends StatefulWidget {
  const StoryMore({super.key, this.isPostMine = false, this.postArguments});

  final PostArguments? postArguments;
  final bool isPostMine;

  @override
  State<StoryMore> createState() => _StoryMoreState();
}

class _StoryMoreState extends State<StoryMore> {
  void _sendEmail() async {
    final Email email = Email(
      body: '',
      subject: '[Just 의견 보내기]',
      recipients: ['whddnd0728@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title =
          "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면 친절하게 답변해드릴게요 :)\n\nwhddnd0728@gmail.com";
      showToast(title);
    }
  }

  void _pressedEditButton() {
    Get.back();
    PostWriteController pwc = Get.put(PostWriteController());
    if (widget.postArguments!.pagesText.isNotEmpty) {
      pwc.textControllers.clear();
      widget.postArguments?.pagesText.forEach((element) {
        pwc.textControllers.add(TextEditingController(text: element));
      });
    }

    pwc.totalPage.value = widget.postArguments?.pagesText.length ?? 1;
    pwc.currentPage.value = 0;
    pwc.setImageId(widget.postArguments?.bgImageId ?? 1);
    pwc.tags = widget.postArguments?.postTags ?? [];
    Get.toNamed('/post',
        arguments: PostTypeArguments(widget.postArguments!.postId, 'edit'));
  }

  void _pressedDeleteButton() {
    Get.back();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlatformOkCancelDialog(
          title: '삭제',
          content: '정말 해당 게시글을 삭제하시겠습니까?\n삭제된 게시글은 복구할 수 없어요.',
          okText: '삭제하기',
          cancelText: '취소',
          onPressedOkButton: () async {
            Get.back();
            try {
              EasyLoading.show(status: '삭제중...');
              final response =
                  await deleteStoryPost(widget.postArguments!.postId);

              if (response != null) {
                EasyLoading.showSuccess('글 삭제 성공!');
              } else {
                EasyLoading.showError('글 삭제 실패\n잠시 후 다시 시도해주세요.');
              }
            } catch (e) {
              EasyLoading.showError('글 삭제 실패\n잠시 후 다시 시도해주세요.');
            }
            Get.offAllNamed('/', arguments: 2);
          },
          onPressedCancelButton: () => Get.back(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isPostMine ? 180 : 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (widget.isPostMine)
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('수정하기'),
                onTap: _pressedEditButton,
              ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('삭제하기'),
              onTap: _pressedDeleteButton,
            ),
            if (!widget.isPostMine)
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('게시글 신고'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (context, setState) =>
                                const BlameDialog());
                      });
                },
              ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('의견 보내기'),
              onTap: () {
                _sendEmail();
              },
            ),
          ],
        ),
      ),
    );
  }
}
