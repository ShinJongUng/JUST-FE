import 'package:flutter/material.dart';
import 'package:just/views/widgets/utils/platform_ok_cancel_dialog.dart';
import 'package:just/views/widgets/utils/show_toast.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  int _currentPage = 0;
  int _totalPage = 1;
  final PageController _pageController = PageController();
  final List<TextEditingController> _textControllers = [
    TextEditingController()
  ];
  void showOkCancelDialog() {
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
    if (_totalPage >= 4) {
      showToast('최대 4페이지까지 업로드 가능해요!');
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    _textControllers.insert(_currentPage + 1, TextEditingController());
    setState(() {
      _totalPage++;
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void deleteCurrentPage() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_totalPage <= 1) {
      showToast('최소 1페이지는 업로드 해야해요!');
      return;
    }
    _textControllers.removeAt(_currentPage); // [1, 3]
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
      _totalPage--;
    });
  }

  void pressLeftButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void pressRightButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (_currentPage < _totalPage - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void onPageChanged(value) {
    setState(() {
      _currentPage = value;
    });
  }

  void onPressPostButton() {}

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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(children: [
            Positioned.fill(
              child: Image.asset(
                'assets/test1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: _totalPage,
                controller: _pageController,
                onPageChanged: onPageChanged,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75 -
                            MediaQuery.of(context).viewInsets.bottom,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              controller: _textControllers[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '아무 고민이나 괜찮아요.',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.085,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: _currentPage != 0 ? pressLeftButton : null,
                          icon: const Icon(Icons.chevron_left),
                          disabledColor: Colors.grey,
                        ),
                        IconButton(
                          onPressed: _currentPage != _totalPage - 1
                              ? pressRightButton
                              : null,
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                    Text('${_currentPage + 1}/$_totalPage'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: deleteCurrentPage,
                            icon: const Icon(Icons.delete)),
                        IconButton(
                            onPressed: addNewPage, icon: const Icon(Icons.add)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
    ;
  }
}
