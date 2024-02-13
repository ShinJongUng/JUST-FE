import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/post_write_controller.dart';
import 'package:just/views/widgets/utils/show_toast.dart';

class PostWidget extends StatefulWidget {
  final PageController pageController;

  const PostWidget({
    super.key,
    required this.pageController,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final PostWriteController pwc = Get.find();
  void _updateImage(int imageId) {
    pwc.setImageId(imageId);
  }

  void _addNewPage() {
    if (pwc.totalPage.value >= 4) {
      showToast('최대 4페이지까지 업로드 가능해요!');
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();

    pwc.textControllers
        .insert(pwc.currentPage.value + 1, TextEditingController());
    setState(() {
      pwc.totalPage.value++;
      pwc.currentPage.value++;
      widget.pageController.animateToPage(
        pwc.currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void _deleteCurrentPage() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (pwc.totalPage.value <= 1) {
      showToast('최소 1페이지는 작성 해야해요!');
      return;
    }
    pwc.textControllers.removeAt(pwc.currentPage.value); // [1, 3]
    setState(() {
      if (pwc.currentPage.value > 0) {
        pwc.currentPage.value--;
        widget.pageController.animateToPage(
          pwc.currentPage.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
      pwc.totalPage.value--;
    });
  }

  void _pressLeftButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (pwc.currentPage.value > 0) {
        pwc.currentPage.value--;
        widget.pageController.animateToPage(
          pwc.currentPage.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void _pressRightButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      if (pwc.currentPage.value < pwc.totalPage.value - 1) {
        pwc.currentPage.value++;
        widget.pageController.animateToPage(
          pwc.currentPage.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void _onPageChanged(value) {
    setState(() {
      pwc.currentPage.value = value;
    });
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    pwc.textControllers.map((e) => e.clear());
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(children: [
              const SizedBox(
                height: 12,
              ),
              const Text('배경 사진 선택', style: TextStyle(fontSize: 18)),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: 11,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    String imagePath =
                        'assets/background/background${index + 1}.jpg';
                    return GestureDetector(
                      onTap: () {
                        _updateImage(index + 1);
                        Navigator.pop(context);
                      },
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ]));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: pwc.isPosting.value,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(
          () => Stack(children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background/background${pwc.imageId}.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: pwc.totalPage.value,
                controller: widget.pageController,
                onPageChanged: _onPageChanged,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75 -
                            MediaQuery.of(context).viewInsets.bottom,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextField(
                              controller: pwc.textControllers[index],
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
                          onPressed: pwc.currentPage.value != 0
                              ? _pressLeftButton
                              : null,
                          icon: const Icon(Icons.chevron_left),
                          disabledColor: Colors.grey,
                        ),
                        IconButton(
                          onPressed:
                              pwc.currentPage.value != pwc.totalPage.value - 1
                                  ? _pressRightButton
                                  : null,
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                    Text('${pwc.currentPage.value + 1}/${pwc.totalPage.value}'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: _deleteCurrentPage,
                            icon: const Icon(Icons.delete)),
                        IconButton(
                          onPressed: () => _showImagePickerBottomSheet(context),
                          icon: const Icon(Icons.image),
                        ),
                        IconButton(
                            onPressed: _addNewPage,
                            icon: const Icon(Icons.add)),
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
  }
}
