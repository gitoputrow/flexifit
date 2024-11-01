import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep5 extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
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
                "asset/BackgroundImage/bgIntroScreen5.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          // height: MediaQuery.of(context).size.height,
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
                    controller.setValueFunction("Chest");
                  },
                  title: "Chest",
                  isSelected: controller.targetRes.contains("Chest"),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("Arm's");
                  },
                  title: "Arms",
                  isSelected: controller.targetRes.contains("Arm's"),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("Leg's");
                  },
                  title: "Legs",
                  isSelected: controller.targetRes.contains("Leg's"),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("Abs");
                  },
                  title: "Abs",
                  isSelected: controller.targetRes.contains("Abs"),
                ),
              ),
              SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
