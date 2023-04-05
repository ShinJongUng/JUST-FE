import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just/services/post_story_post.dart';
import 'package:just/views/widgets/post_page/post_widget.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';
import 'package:just/views/widgets/utils/show_toast.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  int currentPage = 0;
  int totalPage = 1;
  bool isPosting = false;
  final PageController _pageController = PageController();
  final List<TextEditingController> _textControllers = [
    TextEditingController()
  ];

  void showOkCancelDialog() {
    if (isPosting) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PlatformOkCancelDialog(
          title: '글 작성 취소',
          content: '글 작성을 취소하시면 모든 내용이 사라져요. 취소하시겠어요?',
          okText: '작성 취소',
          cancelText: '계속 작성하기',
          okTextColor: Colors.red,
        );
      },
    );
  }

  void addNewPage() {
    if (totalPage >= 4) {
      showToast('최대 4페이지까지 업로드 가능해요!');
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    _textControllers.insert(currentPage + 1, TextEditingController());
    setState(() {
      totalPage++;
      currentPage++;
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void deleteCurrentPage() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (totalPage <= 1) {
      showToast('최소 1페이지는 업로드 해야해요!');
      return;
    }
    _textControllers.removeAt(currentPage); // [1, 3]
    setState(() {
      if (currentPage > 0) {
        currentPage--;
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
      totalPage--;
    });
  }

  void pressLeftButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (currentPage > 0) {
        currentPage--;
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void pressRightButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (currentPage < totalPage - 1) {
        currentPage++;
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void onPageChanged(value) {
    setState(() {
      currentPage = value;
    });
  }

  void onPressPostButton() async {
    if (isPosting) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (_textControllers[0].text.isEmpty) {
      showToast('글 내용을 입력해주세요!');
      return;
    } else {
      try {
        // final List<String> pages = _textControllers
        //     .map((controller) => controller.text)
        //     .toList(growable: false);
        final response = await postStoryPost(_textControllers[0].text);
        EasyLoading.show(status: '로딩중...');
        isPosting = true;
        if (response != null) {
          showToast('글 작성에 성공했어요!');
          EasyLoading.showSuccess('작성 성공!');
          isPosting = false;
          Get.back();
        } else {
          showToast('글 작성에 실패했어요. 다시 시도해주세요!');
          isPosting = false;
          EasyLoading.showError('작성 실패');
        }
      } catch (e) {
        showToast('글 작성에 실패했어요. 다시 시도해주세요!');
        isPosting = false;
        EasyLoading.showError('작성 실패');
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text('글 작성 페이지'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              showOkCancelDialog();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: onPressPostButton,
            ),
          ],
        ),
        body: PostWidget(
            currentPage: currentPage,
            totalPage: totalPage,
            textControllers: _textControllers,
            pageController: _pageController,
            isPosting: isPosting,
            addNewPage: addNewPage,
            deleteCurrentPage: deleteCurrentPage,
            pressLeftButton: pressLeftButton,
            pressRightButton: pressRightButton,
            onPageChanged: onPageChanged),
      ),
    );
  }
}
