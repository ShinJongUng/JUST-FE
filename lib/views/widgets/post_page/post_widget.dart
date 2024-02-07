import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/post_write_controller.dart';

class PostWidget extends StatefulWidget {
  final int currentPage;
  final int totalPage;
  final bool isPosting;
  final PageController pageController;
  final List<TextEditingController> textControllers;
  final Function(dynamic value) onPageChanged;
  final Function() addNewPage;
  final Function() deleteCurrentPage;
  final Function() pressLeftButton;
  final Function() pressRightButton;

  const PostWidget({
    super.key,
    required this.currentPage,
    required this.totalPage,
    required this.isPosting,
    required this.pageController,
    required this.textControllers,
    required this.onPageChanged,
    required this.addNewPage,
    required this.deleteCurrentPage,
    required this.pressLeftButton,
    required this.pressRightButton,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final PostWriteController pwc = Get.put(PostWriteController());
  void _updateImage(int imageId) {
    pwc.setImageId(imageId);
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    widget.textControllers.map((e) => e.clear());
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
      ignoring: widget.isPosting,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background/background${pwc.imageId}.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: PageView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: widget.totalPage,
              controller: widget.pageController,
              onPageChanged: widget.onPageChanged,
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
                            controller: widget.textControllers[index],
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
                        onPressed: widget.currentPage != 0
                            ? widget.pressLeftButton
                            : null,
                        icon: const Icon(Icons.chevron_left),
                        disabledColor: Colors.grey,
                      ),
                      IconButton(
                        onPressed: widget.currentPage != widget.totalPage - 1
                            ? widget.pressRightButton
                            : null,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  Text('${widget.currentPage + 1}/${widget.totalPage}'),
                  Row(
                    children: [
                      IconButton(
                          onPressed: widget.deleteCurrentPage,
                          icon: const Icon(Icons.delete)),
                      IconButton(
                        onPressed: () => _showImagePickerBottomSheet(context),
                        icon: const Icon(Icons.image),
                      ),
                      IconButton(
                          onPressed: widget.addNewPage,
                          icon: const Icon(Icons.add)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
