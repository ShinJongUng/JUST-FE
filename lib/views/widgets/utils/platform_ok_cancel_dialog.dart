import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PlatformOkCancelDialog extends StatelessWidget {
  final String title;
  final String content;
  final String okText;
  final String cancelText;
  final Function() onPressedOkButton;
  final Function() onPressedCancelButton;
  final Color okTextColor;
  const PlatformOkCancelDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.okText,
      required this.cancelText,
      required this.onPressedOkButton,
      required this.onPressedCancelButton,
      this.okTextColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: onPressedCancelButton,
            child: Text(cancelText),
          ),
          CupertinoDialogAction(
            onPressed: onPressedOkButton,
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
            onPressed: onPressedOkButton,
            child: Text(okText),
          ),
          TextButton(
            onPressed: onPressedCancelButton,
            child: Text(cancelText),
          ),
        ],
      );
    }
  }
}
