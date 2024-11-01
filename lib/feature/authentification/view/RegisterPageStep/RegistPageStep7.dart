import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/widget/CustomRadioButton.dart';
import 'package:pain/widget/TextFieldCustom.dart';

import '../../../../theme/colors.dart';

class RegistPageStep7 extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Stack(
        children: [
          SizedBox(
            height: context.height,
            width: context.width,
            child: Opacity(
              opacity: 0.6,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 124, 124, 124),
                    BlendMode.saturation),
                child: Image.asset(
                  "asset/BackgroundImage/bgIntroScreen7.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.075),
            child: FormBuilder(
              key: controller.formAccount,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 115,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontFamily: 'PoppinsBoldSemi',
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Set your Username & Password\nso you can keep your Account ",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        fontFamily: 'PoppinsMedium',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height < 800 ? 40 : 50,
                  ),
                  TextFieldCustom(
                    name: "email",
                    onChanged: (text) {
                      controller.continueRegistFunc();
                    },
                    borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                    textController: controller.email.value,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Insert your Email",
                    imageSource: "asset/Icon/emaiIcon.png",
                    prefixIconScale: 11,
                    fillColor: Color.fromRGBO(10, 12, 13, 0.8),
                    prefixColor: Colors.white,
                    hintTextColor: Colors.white30,
                    textColor: Colors.white,
                    widthTextField: 1,
                  ),
                  SizedBox(height: 26,),
                  TextFieldCustom(
                    name: "username",
                    onChanged: (text) {
                      controller.continueRegistFunc();
                    },
                    borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                    textController: controller.username.value,
                    keyboardType: TextInputType.text,
                    hintText: "Insert your username",
                    imageSource: "asset/Icon/profileIcon.png",
                    prefixIconScale: 11,
                    fillColor: Color.fromRGBO(10, 12, 13, 0.8),
                    prefixColor: Colors.white,
                    hintTextColor: Colors.white30,
                    textColor: Colors.white,
                    widthTextField: 1,
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Obx(
                    () => TextFieldCustom(
                      name: "pass",
                      onChanged: (text) {
                        controller.continueRegistFunc();
                      },
                      textController: controller.password.value,
                      keyboardType: TextInputType.text,
                      hintText: "Set your password",
                      borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                      imageSource: "asset/Icon/passIcon.png",
                      
                      prefixIconScale: 11,
                      isObscureText: true,
                      fillColor: Color.fromRGBO(10, 12, 13, 0.8),
                      prefixColor: Colors.white,
                      hintTextColor: Colors.white30,
                      textColor: Colors.white,
                      widthTextField: 1,
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Obx(
                    () => TextFieldCustom(
                      name: "pass_confirm",
                      onChanged: (text) {
                        controller.continueRegistFunc();
                      },
                      textController: controller.cpassword.value,
                      keyboardType: TextInputType.text,
                      hintText: "Confirm your password",
                      imageSource: "asset/Icon/passIcon.png",
                      prefixIconScale: 11,
                      borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                      fillColor: Color.fromRGBO(10, 12, 13, 0.8),
                      prefixColor: Colors.white,
                      hintTextColor: Colors.white30,
                      textColor: Colors.white,
                      widthTextField: 1,
                      isObscureText: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
