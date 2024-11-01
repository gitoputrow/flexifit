import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/RegisterController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep3 extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: context.height,
          width: context.width,
          child: Opacity(
            opacity: 0.5,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 124, 124, 124),
                  BlendMode.saturation),
              child: Image.asset(
                "asset/BackgroundImage/bgIntroScreen3.png",
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
                  "Set your Goal!",
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
                height: MediaQuery.of(context).size.height < 800 ? 40 : 50,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("build");
                  },
                  title: "Build Muscle",
                  fontSize: 21,
                  subTextTitle: 'Build mass & Strength',
                  isSelected: controller.goalRes == 'build',
                  
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Obx(
                () => CustomRadioButton(
                  onPressed: () {
                    controller.setValueFunction("burn");
                  },
                  title: "Burn Fat",
                  fontSize: 21,
                  subTextTitle: 'Burn extra fat & Feel energized',
                  isSelected: controller.goalRes == 'burn',
                  
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Change your goal anytime in Settings.",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontFamily: 'PoppinsBoldSemi',
                      fontSize: 13,
                      color: Color.fromRGBO(255, 255, 255, 0.6)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
