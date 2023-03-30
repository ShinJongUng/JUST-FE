import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentSheetHeader extends StatelessWidget {
  const CommentSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.close,
                size: 18,
              )),
        ),
        title: const Text(
          "댓글",
          textAlign: TextAlign.center,
        ));
  }
}
