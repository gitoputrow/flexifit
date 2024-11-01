import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep4 extends GetView<RegisterController> {
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
                "asset/BackgroundImage/bgIntroScreen4.png",
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
              height: MediaQuery.of(context).size.height < 800 ? 40 : 50,
            ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("1");
                  },
                  title: "Being healthier",
                  fontSize: 22,
                  isSelected: controller.motivRes.contains("1"),
                  
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("2");
                  },
                  isSelected: controller.motivRes.contains("2"),
                  title: "Looking better",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("3");
                  },
                  isSelected: controller.motivRes.contains("3"),
                  title: "For strength & endurance",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("4");
                  },
                  fontSize: 22,
                  title: "Reducing stress or tension",
                  isSelected: controller.motivRes.contains("4"),
                  
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("5");
                  },
                  fontSize: 22,
                  title: "Boosting confidence",
                  isSelected: controller.motivRes.contains("5"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
