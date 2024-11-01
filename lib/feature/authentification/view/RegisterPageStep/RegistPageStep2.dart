import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep2 extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: context.height,
          width: context.width,
          child: Opacity(
            opacity: 0.4,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 124, 124, 124),
                  BlendMode.saturation),
              child: Image.asset(
                "asset/BackgroundImage/bgIntroScreen2.png",
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
                  "How physically Active\nare you?",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    fontFamily: 'PoppinsBoldSemi',
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 800 ? 35 : 50,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("new");
                  },
                  title: "Not much",
                  fontSize: 21,
                  subTextTitle: "Out of Shape",
                  isSelected: controller.physicalRes == 'new',
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("newb");
                  },
                  title: "1-2 Workouts",
                  fontSize: 21,
                  subTextTitle: "a week",
                  isSelected: controller.physicalRes == "newb",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("pro");
                  },
                  title: "3-4 Workouts",
                  fontSize: 21,
                  subTextTitle: "a week",
                  isSelected: controller.physicalRes == 'pro',
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("master");
                  },
                  title: "5+ Workout",
                  fontSize: 21,
                  subTextTitle: 'a week',
                  isSelected: controller.physicalRes == 'master',
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
