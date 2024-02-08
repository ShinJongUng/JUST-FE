import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';

class PlatformOkCancelDialog extends StatelessWidget {
  final String title;
  final String content;
  final String okText;
  final String cancelText;
  final Color okTextColor;
  const PlatformOkCancelDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.okText,
      required this.cancelText,
      this.okTextColor = Colors.blue});

  pressedOkButton() {
    Get.back();
    Get.back();
  }

  pressedCancelButton() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: pressedCancelButton,
            child: Text(cancelText),
          ),
          CupertinoDialogAction(
            onPressed: pressedOkButton,
            child: Text(okText, style: TextStyle(color: okTextColor)),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: pressedOkButton,
            child: Text(okText),
          ),
          TextButton(
            onPressed: pressedCancelButton,
            child: Text(cancelText),
          ),
        ],
      );
    }
  }
}
