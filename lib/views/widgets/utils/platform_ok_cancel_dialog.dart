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

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(cancelText),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            child: Text(okText, style: TextStyle(color: okTextColor)),
            onPressed: () {
              Get.back();
              Get.back();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(okText),
            onPressed: () {
              Get.back();
              Get.back();
            },
          ),
          TextButton(
            child: Text(cancelText),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    }
  }
}
