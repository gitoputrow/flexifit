import 'package:get/get.dart';

import '../controller/WorkoutController.dart';

class WorkoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<WorkoutController>(WorkoutController());
  }
}