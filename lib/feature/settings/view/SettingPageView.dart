import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/HeaderPageWidget.dart';
import '../../../widget/CustomAlertDialog.dart';
import '../controller/SettingController.dart';

class SettingPageView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(child: SizedBox(height: 24)),
          HeaderPageWidget(text: "Settings"),
          SizedBox(
            height: 35,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ButtonCustomMain(
                onPressed: () {
                  Get.toNamed("/editprofilepage");
                },
                title: "Edit Profile",
                icon: Icon(Icons.person, color: Colors.white, size: 28),
                primary: tertiaryColor,
                colorText: Colors.white,
                alignment: MainAxisAlignment.spaceBetween,
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
                  Get.toNamed("/editpasswordpage");
                },
                title: "Edit Password",
                icon: Icon(Icons.password_rounded, color: Colors.white, size: 28),
                primary: tertiaryColor,
                colorText: Colors.white,
                alignment: MainAxisAlignment.spaceBetween,
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
                primary: primaryDarkColor,
                icon: Icon(Icons.delete, color: Colors.white, size: 28),
                colorText: Colors.white,
                alignment: MainAxisAlignment.spaceBetween,
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
                      primary: primaryColor,
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
    );
  }
}
