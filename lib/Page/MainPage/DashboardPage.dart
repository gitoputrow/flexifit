import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/widget/CustomBottomNav.dart';
import 'package:pain/widget/Loading.dart';

import '../../controller/DashboardController.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver {
  final controller = Get.find<DashboardController>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Obx((() => SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(10, 12, 13, 1),
            extendBody: false,
            body: controller.loading ? Loading() : controller.pages[controller.currentIndex],
            bottomNavigationBar: controller.loading ? SizedBox() :
                CustomBottomNav(index: controller.currentIndex, onTap: controller.changePage)
          )
        )
      )
    );
  }
}
