import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/BasicLoader.dart';
import 'package:pain/widget/ButtonCustomMain.dart';
import 'package:pain/widget/ToastMessageCustom.dart';

class RegisterPage extends GetView<AuthentificationController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          if (controller.indexRegist == 0) {
            return Future.value(true);
          } else {
            controller.indexRegist = controller.indexRegist - 1;
            controller.continueRegistFunc();
            return Future.value(false);
          }
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewPadding.top - MediaQuery.of(context).viewPadding.bottom,
              child: Stack(
                children: [
                  Obx(() => controller.StepPage[controller.indexRegist]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 56,
                      ),
                      Obx(() => controller.pagination[controller.indexRegist]),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(
                              () => Container(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.075),
                                child: ButtonCustomMain(
                                  alignText: Alignment.center,
                                  borderRadius: 30,
                                  colorText: Colors.white,
                                  permission: controller.continuePermission,
                                  onPressed: () async {
                                    if (controller.continuePermission == true &&
                                        controller.indexRegist != 6) {
                                      controller.indexRegist = controller.indexRegist + 1;
                                      controller.continueRegistFunc();
                                    }
                                    if (controller.continuePermission == true &&
                                        controller.indexRegist == 6) {
                                      await controller.regist();
                                    }
                                  },
                                  title: controller.RegistButTitle[
                                      controller.indexRegist < 5 ? 0 : controller.indexRegist - 4],
                                  primary: Color.fromRGBO(170, 5, 27, 1),
                                  primaryFalse: Color.fromRGBO(205, 2, 27, 0.4),
                                  colorTextFalse: Color.fromRGBO(255, 255, 255, 0.4),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height < 800 ? 35 : 65,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 43,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: IconButton(
                            onPressed: () {
                              if (controller.indexRegist == 0) {
                                Get.back();
                              } else {
                                controller.indexRegist = controller.indexRegist - 1;
                                controller.continueRegistFunc();
                              }
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
