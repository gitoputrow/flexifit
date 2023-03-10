import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/ButtonCustomMain.dart';

import '../../../widget/CustomAlertDialog.dart';

class SettingPage extends GetView<DashboardController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(47, 47, 47, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40.5),
                  alignment: Alignment.center,
                  child: Text(
                    "Setting",
                    style:
                        TextStyle(fontSize: 24, fontFamily: 'PoppinsBoldSemi', color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 30),
                  child: IconButton(
                    icon: Image.asset("asset/Image/backsetting.png"),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ButtonCustomMain(
                  onPressed: () {
                    Get.toNamed("/editprofilepage",arguments: controller.user);
                  },
                  title: "Edit Profile",
                  primary: Color.fromRGBO(255, 255, 255, 0.25),
                  colorText: Colors.white,
                  alignText: Alignment.centerLeft,
                  borderRadius: 15,
                  permission: true),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ButtonCustomMain(
                  onPressed: () {
                    Get.toNamed("/editpasswordpage",arguments: controller.user);
                  },
                  title: "Edit Password",
                  primary: Color.fromRGBO(255, 255, 255, 0.25),
                  colorText: Colors.white,
                  alignText: Alignment.centerLeft,
                  borderRadius: 15,
                  permission: true),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ButtonCustomMain(
                  onPressed: () {
                    Get.dialog(CustomAlertDialog(
                              onPressedno: () {
                                Get.back();
                              },
                              onPressedyes: () async {
                                await controller.deleteAccount();
                              },
                              backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
                              title: "Do you want to Delete Your Account?",
                              fontColor: Color.fromARGB(204, 255, 255, 255),
                              fontSize: 20,
                              iconColor: Colors.white));
                  },
                  title: "Delete Account",
                  primary: Color.fromRGBO(205, 5, 27, 0.8),
                  colorText: Colors.white,
                  alignText: Alignment.centerLeft,
                  borderRadius: 15,
                  permission: true),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: ButtonCustomMain(
                        onPressed: () async {
                          Get.dialog(CustomAlertDialog(
                              onPressedno: () {
                                Get.back();
                              },
                              onPressedyes: () async {
                                await controller.logout();
                              },
                              backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
                              title: "Do you want to logout?",
                              fontColor: Color.fromARGB(204, 255, 255, 255),
                              fontSize: 20,
                              iconColor: Colors.white));
                        },
                        title: "Logout",
                        primary: Color.fromRGBO(255, 255, 255, 0.25),
                        colorText: Colors.white,
                        alignText: Alignment.center,
                        borderRadius: 15,
                        permission: true),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
