import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlameDialog extends StatefulWidget {
  const BlameDialog({super.key});

  @override
  State<BlameDialog> createState() => _BlameDialogState();
}

class _BlameDialogState extends State<BlameDialog> {
  @override
  Widget build(BuildContext context) {
    int number = 0;

    return SimpleDialog(
      title: const Text("게시글 신고"),
      children: [
        RadioListTile(
          title: const Text("성적인 게시글"),
          value: 1,
          groupValue: number,
          onChanged: (int? value) {
            setState(() {
              number = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text("폭력적 또는 혐오스러운 게시글"),
          value: 2,
          groupValue: number,
          onChanged: (int? value) {
            setState(() {
              number = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text("상업적 광고 및 판매"),
          value: 3,
          groupValue: number,
          onChanged: (int? value) {
            setState(() {
              number = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text("사회적 갈등 조장"),
          value: 4,
          groupValue: number,
          onChanged: (int? value) {
            setState(() {
              number = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text("욕설 및 비방"),
          value: 5,
          groupValue: number,
          onChanged: (int? value) {
            setState(() {
              number = value!;
            });
          },
        ),
        RadioListTile(
          title: const Text("불쾌한 내용"),
          value: 6,
          groupValue: number,
          onChanged: (int? value) {
            setState(() {
              number = value!;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("취소")),
              const SizedBox(width: 8),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  onPressed: () {},
                  child: const Text("신고하기")),
            ],
          ),
        )
      ],
    );
  }
}
