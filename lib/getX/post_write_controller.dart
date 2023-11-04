// post_controller.dart
import 'package:get/get.dart';

class PostWriteController extends GetxController {
  final RxInt imageId = 1.obs;

  void setImageId(int id) {
    imageId.value = id;
  }
}
