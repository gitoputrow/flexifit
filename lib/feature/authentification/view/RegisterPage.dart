import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/widget/BasicLoader.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/ToastMessageCustom.dart';

class RegisterPage extends GetView<RegisterController> {
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
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top -
                  MediaQuery.of(context).viewPadding.bottom,
              child: Stack(
                children: [
                  Obx(() => controller.stepPage[controller.indexRegist]),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.075),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 56,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  if (controller.indexRegist == 0) {
                                    Get.back();
                                  } else {
                                    controller.indexRegist =
                                        controller.indexRegist - 1;
                                    controller.continueRegistFunc();
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 30,
                                )),
                            Obx(() =>
                                controller.pagination[controller.indexRegist]),
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white.withOpacity(0),
                                  size: 30,
                                ))
                          ],
                        ),
                        Spacer(),
                        Obx(
                          () => ButtonCustomMain(
                            alignText: Alignment.center,
                            borderRadius: 30,
                            permission: controller.continuePermission,
                            onPressed: () async {
                              if (controller.continuePermission == true) {
                                if (controller.indexRegist != 6) {
                                  if (controller.indexRegist == 5) {
                                    controller.formProfile.currentState!.save();
                                    controller.payload.addAll(controller
                                        .formProfile.currentState!.value);
                                  }
                                  controller.indexRegist =
                                      controller.indexRegist + 1;
                                  controller.continueRegistFunc();
                                } else {
                                  controller.formAccount.currentState!.save();
                                  controller.payload.addAll(controller
                                      .formAccount.currentState!.value);
                                  await controller.regist();
                                }
                              }
                            },
                            title: controller.registButTitle[
                                controller.indexRegist < 5
                                    ? 0
                                    : controller.indexRegist - 4],
                          ),
                        ),
                        SizedBox(
                          height: 36,
                        )
                      ],
                    ),
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
