import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
