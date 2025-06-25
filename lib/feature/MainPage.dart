import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/MainController.dart';
import 'package:pain/widget/CustomBottomNav.dart';
import 'package:pain/widget/Loading.dart';

import '../controller/DashboardController.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((() => SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(10, 12, 13, 1),
            extendBody: false,
            body: controller.pages[controller.currentIndex],
            bottomNavigationBar: CustomBottomNav(
                index: controller.currentIndex,
                onTap: controller.changePage)))));
  }
}
