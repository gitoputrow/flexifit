import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/ForgotPasswordController.dart';
import 'package:pain/theme/colors.dart';

import '../../../widget/CustomButton.dart';
import '../../../widget/HeaderPageWidget.dart';
import '../../../widget/TextFieldCustom.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const HeaderPageWidget(
                  text: "Forgot Password",
                  padding: EdgeInsets.symmetric(horizontal: 0),
                ),
                const SizedBox(
                  height: 28,
                ),
                Text("A reset link will be sent to THE registered email address.".toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      color: primaryTextColor,
                      fontFamily: "PoppinsBold",
                    )),
                const SizedBox(
                  height: 4,
                ),
                Text("Don't Forget To CHeck your spam.".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontFamily: "PoppinsBoldSemi",
                    )),
                SizedBox(
                  height: 24,
                ),
                FormBuilder(
                  key: controller.form,
                  child: TextFieldCustom(
                    name: "username",
                    keyboardType: TextInputType.name,
                    hintText: "Insert Your Username",
                    imageSource: "asset/Icon/profileIconLogin.png",
                  ),
                ),
                Spacer(),
                ButtonCustomMain(
                  borderRadius: 30,
                  onPressed: () async {
                    await controller.sendForgotPassword();
                  },
                  title: "Send Reset Password",
                ),
                SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
