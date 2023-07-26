import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep5 extends GetView<AuthentificationController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: width * 0.075),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/BackgroundImage/bgIntroScreen5.png"), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             SizedBox(
            height: MediaQuery.of(context).size.height < 800 ? 115 : 125,
          ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Choose your target Zones!",
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
            height: MediaQuery.of(context).size.height < 800 ? 40 : 50,
          ),
            Obx(
              () => CustomRadioButton(
                onPressed: () {
                  controller.DropButFunction(5, "Chest");
                },
                title: "Chest",
                fontSize: 22,
                subText: null,
                colorText: !controller.targetRes.contains("Chest")
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(10, 12, 13, 0.8),
                colorButton: !controller.targetRes.contains("Chest")
                    ? Color.fromRGBO(10, 12, 13, 0.8)
                    : Color.fromRGBO(255, 255, 255, 0.8),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => CustomRadioButton(
                onPressed: () {
                  controller.DropButFunction(5, "Arm's");
                },
                fontSize: 22,
                subText: null,
                title: "Arms",
                colorText: !controller.targetRes.contains("Arm's")
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(10, 12, 13, 0.8),
                colorButton: !controller.targetRes.contains("Arm's")
                    ? Color.fromRGBO(10, 12, 13, 0.8)
                    : Color.fromRGBO(255, 255, 255, 0.8),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => CustomRadioButton(
                onPressed: () {
                  controller.DropButFunction(5, "Leg's");
                },
                fontSize: 22,
                subText: null,
                title: "Legs",
                colorText: !controller.targetRes.contains("Leg's")
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(10, 12, 13, 0.8),
                colorButton: !controller.targetRes.contains("Leg's")
                    ? Color.fromRGBO(10, 12, 13, 0.8)
                    : Color.fromRGBO(255, 255, 255, 0.8),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => CustomRadioButton(
                onPressed: () {
                  controller.DropButFunction(5, "Abs");
                },
                fontSize: 22,
                subText: null,
                title: "Abs",
                colorText: !controller.targetRes.contains("Abs")
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(10, 12, 13, 0.8),
                colorButton: !controller.targetRes.contains("Abs")
                    ? Color.fromRGBO(10, 12, 13, 0.8)
                    : Color.fromRGBO(255, 255, 255, 0.8),
              ),
            ),
            SizedBox(
              height: 26,
            ),
          ],
        ),
      ),
    );
  }
}
