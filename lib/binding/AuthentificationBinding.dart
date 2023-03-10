import 'package:get/get.dart';

import '../controller/AuthetificationController.dart';

class AuthentificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthentificationController>(() => AuthentificationController());
  }
}
