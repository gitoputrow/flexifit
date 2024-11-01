import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep1 extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: context.height,
          width: context.width,
          child: Opacity(
            opacity: 0.7,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 124, 124, 124),
                  BlendMode.saturation),
              child: Image.asset(
                "asset/BackgroundImage/bgIntroScreen1.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.075),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height < 800 ? 115 : 125,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "What is your Gender?",
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontFamily: 'PoppinsBoldSemi',
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 800 ? 40 : 50,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("male");
                  },
                  title: "Male",
                  isSelected: controller.genderRes == 'male',
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Obx(() => CustomRadioButton(
                    onPressed: () {
                      controller.setValueFunction("female");
                    },
                    title: "Female",
                    isSelected: controller.genderRes == 'female',
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
