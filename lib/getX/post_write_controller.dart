// post_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

class PostWriteController extends GetxController {
  final currentPage = 0.obs;
  final totalPage = 1.obs;
  final isPosting = false.obs;
  final RxList<TextEditingController> textControllers =
      <TextEditingController>[TextEditingController()].obs;
  TextfieldTagsController tagController = TextfieldTagsController();
  final RxInt imageId = 1.obs;
  List<String> tags = [];

  void setImageId(int id) {
    imageId.value = id;
  }

  void syncTag() {
    tags = tagController.getTags!;
  }

  @override
  void onClose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    debugPrint('PostWriteController is closed');
    super.onClose();
  }
}
