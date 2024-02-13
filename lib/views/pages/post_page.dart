import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/post_write_controller.dart';
import 'package:just/models/post_type_arguments.dart';
import 'package:just/views/widgets/post_page/post_widget.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';
import 'package:just/views/widgets/utils/show_toast.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PageController _pageController = PageController();
  final PostWriteController pwc = Get.put(PostWriteController());

  @override
  Widget build(BuildContext context) {
    final PostTypeArguments postTypeArguments =
        ModalRoute.of(context)?.settings.arguments as PostTypeArguments;
    final bool isEdit = postTypeArguments.postType == 'edit';

    void onPressedNextButton() async {
      if (pwc.isPosting.value) return;
      FocusManager.instance.primaryFocus?.unfocus();

      for (var controller in pwc.textControllers) {
        if (controller.text.trim().isEmpty) {
          showToast('모든 페이지의 글 내용을 입력해주세요!');
          return;
        }
      }

      Get.toNamed('/post-tag', arguments: postTypeArguments);
    }

    void showOkCancelDialog() {
      if (pwc.isPosting.value) return;
      FocusManager.instance.primaryFocus?.unfocus();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlatformOkCancelDialog(
            title: isEdit ? '글 수정 취소' : '글 작성 취소',
            content: isEdit
                ? '글 수정을 취소하면 작성했던 내용이 사라져요. 취소하시겠어요?'
                : '글 작성을 취소하시면 모든 내용이 사라져요. 취소하시겠어요?',
            okText: isEdit ? '수정 취소' : '작성 취소',
            cancelText: '계속 작성하기',
            onPressedOkButton: () {
              Get.back();
              Get.back();
              Future.delayed(const Duration(milliseconds: 500), () {
                Get.delete<PostWriteController>();
              });
            },
            onPressedCancelButton: () => Get.back(),
            okTextColor: Colors.red,
          );
        },
      );
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        showOkCancelDialog();
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(isEdit ? '글 수정' : '글 작성'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              showOkCancelDialog();
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: onPressedNextButton,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text('다음'),
            ),
          ],
        ),
        body: PostWidget(
          pageController: _pageController,
        ),
      ),
    );
  }
}
