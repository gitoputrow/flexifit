import 'package:get/get.dart';

import '../controller/SettingController.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingController>(SettingController());
  }
}