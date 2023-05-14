import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/TextFieldSettingCustom.dart';

import '../../../controller/SettingController.dart';
import '../../../widget/ButtonCustomMain.dart';

class EditPasswordPage extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color.fromRGBO(47, 47, 47, 1),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.045,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40.5),
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Password",
                          style: TextStyle(
                              fontSize: 24, fontFamily: 'PoppinsBoldSemi', color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 30),
                        child: IconButton(
                          icon: Image.asset("asset/Image/backsetting.png"),
                          iconSize: 40,
                          onPressed: () {
                            controller.getBackEPassword();
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => TextFieldSettingCustom(
                            title: "Old Password",
                            keyboardType: TextInputType.text,
                            onTextChanged: (text) {
                              controller.buttonPermissionEPass();
                            },
                            SuffixIcon: Container(
                              padding: EdgeInsets.only(right: 0),
                              child: IconButton(
                                icon: controller.oldPassView == false
                                    ? Image.asset(
                                        "asset/Image/hidepass_Epass.png",
                                        width: 30,
                                        height: 30,
                                      )
                                    : Image.asset(
                                        "asset/Image/unhidepass_Epass.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                onPressed: () {
                                  controller.oldPassView =
                                      controller.oldPassView == false ? true : false;
                                },
                              ),
                            ),
                            condition: controller.oldPassView,
                            hintText: "Enter Old Password",
                            controller: controller.oldPass)),
                        SizedBox(
                          height: 30,
                        ),
                        Obx(() => TextFieldSettingCustom(
                            title: "New Password",
                            keyboardType: TextInputType.text,
                            onTextChanged: (text) {
                              controller.buttonPermissionEPass();
                            },
                            SuffixIcon: Container(
                              padding: EdgeInsets.only(right: 0),
                              child: IconButton(
                                icon: controller.newPassView == false
                                    ? Image.asset(
                                        "asset/Image/hidepass_Epass.png",
                                        width: 30,
                                        height: 30,
                                      )
                                    : Image.asset(
                                        "asset/Image/unhidepass_Epass.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                onPressed: () {
                                  controller.newPassView =
                                      controller.newPassView == false ? true : false;
                                },
                              ),
                            ),
                            condition: controller.newPassView,
                            hintText: "Enter New Password",
                            controller: controller.newPass)),
                        SizedBox(
                          height: 30,
                        ),
                        Obx(() => TextFieldSettingCustom(
                            title: "Confirm New Password",
                            keyboardType: TextInputType.text,
                            onTextChanged: (text) {
                              print("ytest");
                              controller.buttonPermissionEPass();
                            },
                            SuffixIcon: Container(
                              padding: EdgeInsets.only(right: 0),
                              child: IconButton(
                                icon: controller.cNewPassView == false
                                    ? Image.asset(
                                        "asset/Image/hidepass_Epass.png",
                                        width: 30,
                                        height: 30,
                                      )
                                    : Image.asset(
                                        "asset/Image/unhidepass_Epass.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                onPressed: () {
                                  controller.cNewPassView =
                                      controller.cNewPassView == false ? true : false;
                                },
                              ),
                            ),
                            condition: controller.cNewPassView,
                            hintText: "Confirm New Password",
                            controller: controller.cNewPass)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Obx(
                                      () => ButtonCustomMain(
                                          onPressed: () {
                                            if (controller.buttonPermEPass == true) {
                                              controller.discardEPass();
                                              controller.buttonPermissionEPass();
                                            }
                                          },
                                          alignText: Alignment.center,
                                          borderRadius: 15,
                                          title: "Discard",
                                          colorTextFalse: Color.fromRGBO(255, 255, 255, 0.4),
                                          primaryFalse: Color.fromRGBO(255, 255, 255, 0.1),
                                          colorText: Colors.white,
                                          primary: Color.fromRGBO(255, 255, 255, 0.3),
                                          permission: controller.buttonPermEPass),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Obx(
                                      () => ButtonCustomMain(
                                          onPressed: () {
                                            if (controller.buttonPermEPass == true) {
                                              print(controller.user.pass);
                                              controller.changePassword();
                                            }
                                          },
                                          alignText: Alignment.center,
                                          borderRadius: 15,
                                          colorText: Colors.black,
                                          title: "Save",
                                          colorTextFalse: Color.fromRGBO(0, 0, 0, 0.6),
                                          primaryFalse: Color.fromRGBO(255, 255, 255, 0.5),
                                          primary: Color.fromRGBO(255, 255, 255, 1),
                                          permission: controller.buttonPermEPass),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
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
