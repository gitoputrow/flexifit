import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/settings/controller/EditPasswordController.dart';
import 'package:pain/widget/TextFieldSettingCustom.dart';
import '../../../theme/colors.dart';
import '../../../widget/CustomButton.dart';
import '../../../widget/HeaderPageWidget.dart';
import '../../../widget/TextFieldCustom.dart';

class EditPasswordPage extends GetView<EditPasswordController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SafeArea(
                    child: SizedBox(
                      height: 28,
                    ),
                  ),
                HeaderPageWidget(
                  text: "Edit Password",
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => TextFieldCustom(
                          name: "old_pass",
                          label: "Old Password",
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            controller.buttonPermissionEPass();
                          },
                          fillColor: Colors.transparent,
                          borderColorEnabled: secondaryColor,
                          borderColorFocused: primaryColor,
                          textColor: Colors.white,
                          contentPadding: EdgeInsets.all(20),
                          isObscureText: true,
                          hintText: "Enter Old Password",
                          textController: controller.oldPass)),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => TextFieldCustom(
                          name: "new_pass",
                          label: "New Password",
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            controller.buttonPermissionEPass();
                          },
                          isObscureText: true,
                          fillColor: Colors.transparent,
                          borderColorEnabled: secondaryColor,
                          borderColorFocused: primaryColor,
                          textColor: Colors.white,
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Enter New Password",
                          textController: controller.newPass)),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => TextFieldCustom(
                        name: "c_new_pass",
                          label: "Confirm New Password",
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            print("ytest");
                            controller.buttonPermissionEPass();
                          },
                          isObscureText: true,
                          fillColor: Colors.transparent,
                          borderColorEnabled: secondaryColor,
                          borderColorFocused: primaryColor,
                          textColor: Colors.white,
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Confirm New Password",
                          textController: controller.cNewPass)),
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
                                            controller.changePassword();
                                          }
                                        },
                                        alignText: Alignment.center,
                                        borderRadius: 15,
                                        colorText: Colors.white,
                                        title: "Save",
                                        colorTextFalse: disabledTextColor,
                                        primaryFalse: buttonDiabledColor,
                                        primary: primaryColor,
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
    );
  }
}
