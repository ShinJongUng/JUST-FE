import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryMore extends StatefulWidget {
  const StoryMore({super.key});

  @override
  State<StoryMore> createState() => _StoryMoreState();
}

class _StoryMoreState extends State<StoryMore> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('게시글 신고'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      int _number = 0;

                      return StatefulBuilder(
                          builder: (context, setState) => SimpleDialog(
                                title: const Text("게시글 신고"),
                                children: [
                                  RadioListTile(
                                    title: Text("성적인 게시글"),
                                    value: 1,
                                    groupValue: _number,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _number = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text("폭력적 또는 혐오스러운 게시글"),
                                    value: 2,
                                    groupValue: _number,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _number = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text("법적 문제"),
                                    value: 3,
                                    groupValue: _number,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _number = value!;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent)),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text("취소")),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent)),
                                            onPressed: () {},
                                            child: const Text("신고하기")),
                                      ],
                                    ),
                                  )
                                ],
                              ));
                    });
              },
            ),
            ListTile(
              leading: const Icon(Icons.warning),
              title: const Text('의견 보내기'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
