import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomRadioButton.dart';
import 'package:pain/widget/TextFieldCustom.dart';

class RegistPageStep6 extends GetView<RegisterController> {
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
                  "asset/BackgroundImage/bgIntroScreen6.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.075),
            child: FormBuilder(
              key: controller.formProfile,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height < 800 ? 115 : 125,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Profile Details",
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
                    height: MediaQuery.of(context).size.height < 800 ? 5 : 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Enter your parameters to get a\npersonalized plan",
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
                    name: "name",
                    textController: controller.name.value,
                    onChanged: (text) {
                      controller.continueRegistFunc();
                    },
                    borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                    keyboardType: TextInputType.name,
                    hintText: "Insert your name",
                    imageSource: "asset/Icon/profileIcon.png",
                    prefixIconScale: 11,
                    fillColor: infoColor,
                    prefixColor: Colors.white,
                    hintTextColor: Colors.white30,
                    textColor: primaryTextColor,
                    widthTextField: 1,
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextFieldCustom(
                    name: "age",
                    onChanged: (text) {
                      controller.continueRegistFunc();
                    },
                    borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                    textController: controller.age.value,
                    keyboardType: TextInputType.number,
                    hintText: "Insert your Age",
                    imageSource: "asset/Icon/ageIcon.png",
                    prefixIconScale: 11,
                    fillColor: Color.fromRGBO(10, 12, 13, 0.8),
                    prefixColor: Colors.white,
                    hintTextColor: Colors.white30,
                    textColor: primaryTextColor,
                    widthTextField: 1,
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextFieldCustom(
                    name: "weight",
                    textController: controller.weight.value,
                    onChanged: (text) {
                      controller.continueRegistFunc();
                    },
                    borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                    keyboardType: TextInputType.number,
                    hintText: "Current Weight",
                    imageSource: "asset/Icon/weightIcon.png",
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: width * 0.05),
                          child: Text(
                            "Kg",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  TextFieldCustom(
                    name: "height",
                    onChanged: (text) {
                      controller.continueRegistFunc();
                    },
                    textController: controller.height.value,
                    keyboardType: TextInputType.number,
                    hintText: "Current Height",
                    imageSource: "asset/Icon/heightIcon.png",
                    borderColorEnabled: secondaryTextColor.withOpacity(0.5),
                    borderColorFocused: primaryColor,
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: width * 0.05),
                          child: Text(
                            "Cm",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                    prefixIconScale: 11,
                    fillColor: Color.fromRGBO(10, 12, 13, 0.8),
                    prefixColor: Colors.white,
                    hintTextColor: Colors.white30,
                    textColor: Colors.white,
                    widthTextField: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
