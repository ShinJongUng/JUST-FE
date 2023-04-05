import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isPosting,
      child: GestureDetector(
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
              itemCount: totalPage,
              controller: pageController,
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
                            controller: textControllers[index],
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
                        onPressed: currentPage != 0 ? pressLeftButton : null,
                        icon: const Icon(Icons.chevron_left),
                        disabledColor: Colors.grey,
                      ),
                      IconButton(
                        onPressed: currentPage != totalPage - 1
                            ? pressRightButton
                            : null,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  Text('${currentPage + 1}/$totalPage'),
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
    );
  }
}
