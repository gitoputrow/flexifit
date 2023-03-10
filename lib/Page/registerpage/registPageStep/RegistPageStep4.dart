import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep4 extends GetView<AuthentificationController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.075),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/BackgroundImage/bgIntroScreen4.png"),
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
                "What motivates you to\nExercises?",
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
              height: 50,
            ),
            Obx(
              () => CustomRadioButton(
                  onPressed: () {
                    controller.DropButFunction(4, "1");
                  },
                  title: "Being healthier",
                  fontSize: 22,
                  subText: null,
                  condition: !controller.motivRes.contains("1"),
                   unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                selectedText: Color.fromRGBO(10, 12, 13, 0.8),
                unSelectedBut: Color.fromRGBO(10, 12, 13, 0.8),
                selectedBut: Color.fromRGBO(255, 255, 255, 0.8),),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => CustomRadioButton(
                  onPressed: () {
                    controller.DropButFunction(4, "2");
                  },
                  fontSize: 22,
                  subText: null,
                  title: "Looking better",
                  condition: !controller.motivRes.contains("2"),
                   unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                selectedText: Color.fromRGBO(10, 12, 13, 0.8),
                unSelectedBut: Color.fromRGBO(10, 12, 13, 0.8),
                selectedBut: Color.fromRGBO(255, 255, 255, 0.8),),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => CustomRadioButton(
                  onPressed: () {
                    controller.DropButFunction(4, "3");
                  },
                  fontSize: 22,
                  subText: null,
                  title: "For strength & endurance",
                  condition: !controller.motivRes.contains("3"),
                   unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                selectedText: Color.fromRGBO(10, 12, 13, 0.8),
                unSelectedBut: Color.fromRGBO(10, 12, 13, 0.8),
                selectedBut: Color.fromRGBO(255, 255, 255, 0.8),),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => CustomRadioButton(
                  onPressed: () {
                    controller.DropButFunction(4, "4");
                  },
                  fontSize: 22,
                  subText: null,
                  title: "Reducing stress or tension",
                  condition: !controller.motivRes.contains("4"),
                   unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                selectedText: Color.fromRGBO(10, 12, 13, 0.8),
                unSelectedBut: Color.fromRGBO(10, 12, 13, 0.8),
                selectedBut: Color.fromRGBO(255, 255, 255, 0.8),),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => CustomRadioButton(
                  onPressed: () {
                    controller.DropButFunction(4, "5");
                  },
                  fontSize: 22,
                  subText: null,
                  title: "Boosting confidence",
                  condition: !controller.motivRes.contains("5"),
                   unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                selectedText: Color.fromRGBO(10, 12, 13, 0.8),
                unSelectedBut: Color.fromRGBO(10, 12, 13, 0.8),
                selectedBut: Color.fromRGBO(255, 255, 255, 0.8),),
            ),
          ],
        ),
      ),
    );
  }
}
