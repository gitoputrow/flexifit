import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/AuthetificationController.dart';

class AuthentificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthentificationController>(() => AuthentificationController());
  }
}
