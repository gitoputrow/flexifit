import 'package:get/get.dart';

import '../controller/SosialMediaController.dart';



class SosialMediaBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SosialMediaController>(() => SosialMediaController());
  }
}