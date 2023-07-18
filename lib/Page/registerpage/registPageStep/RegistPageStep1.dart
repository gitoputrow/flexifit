import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep1 extends GetView<AuthentificationController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: width * 0.075),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/BackgroundImage/bgIntroScreen1.png"),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 125,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "What is your Gender?",
              textScaleFactor: 1,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                fontFamily: 'PoppinsBoldSemi',
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Obx(
            () => CustomRadioButton(
                onPressed: () {
                  controller.DropButFunction(1, "male");
                },
                title: "Male",
                fontSize: 22,
                subText: null,
                unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                selectedText: Color.fromRGBO(10, 12, 13, 0.8),
                unSelectedBut: Color.fromRGBO(10, 12, 13, 0.8),
                selectedBut: Color.fromRGBO(255, 255, 255, 0.8),
                condition: controller.genderRes != "male"),
          ),
          SizedBox(
            height: 32,
          ),
          Obx(() => CustomRadioButton(
              onPressed: () {
                controller.DropButFunction(1, "female");
              },
              fontSize: 22,
              subText: null,
              title: "Female",
              condition: controller.genderRes != "female",
               unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                selectedText: Color.fromRGBO(10, 12, 13, 0.8),
                unSelectedBut: Color.fromRGBO(10, 12, 13, 0.8),
                selectedBut: Color.fromRGBO(255, 255, 255, 0.8),))
        ],
      ),
    );
  }
}
