import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:just/views/widgets/utils/show_toast.dart';

class StoryMore extends StatefulWidget {
  const StoryMore({super.key});

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
      print(error);
      String title =
          "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면 친절하게 답변해드릴게요 :)\n\nwhddnd0728@gmail.com";
      showToast(title);
    }
  }

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
                                    title: Text("상업적 광고 및 판매"),
                                    value: 3,
                                    groupValue: _number,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _number = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text("사회적 갈등 조장"),
                                    value: 4,
                                    groupValue: _number,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _number = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text("욕설 및 비방"),
                                    value: 5,
                                    groupValue: _number,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _number = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text("불쾌한 내용"),
                                    value: 6,
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
