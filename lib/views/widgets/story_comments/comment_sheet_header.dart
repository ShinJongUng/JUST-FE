
import 'package:flutter/material.dart';

class CommentSheetHeader extends StatelessWidget {
  const CommentSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
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
