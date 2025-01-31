import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPostPage extends StatelessWidget {
  const UserPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //뒤로가기 버튼 대신 x버튼으로 변경
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("post"),
      ),
      body: const Center(),
    );
  }
}
