import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/CustomRadioButton.dart';

class RegistPageStep3 extends GetView<AuthentificationController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: width * 0.075),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/BackgroundImage/bgIntroScreen3.png"), fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 125,
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
            height: 50,
          ),
          Obx(
            () => CustomRadioButton(
              onPressed: () {
                controller.DropButFunction(3, "build");
              },
              title: "Build Muscle",
              fontSize: 21,
              subText: Text(
                'Build mass & Strength',
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'RubikRegular',
                    fontSize: 16,
                    color: controller.goalRes == "build"
                        ? Color.fromRGBO(10, 12, 13, 0.8)
                        : Color.fromRGBO(255, 255, 255, 0.8)),
              ),
              colorText: controller.goalRes != "build"
                  ? Color.fromRGBO(255, 255, 255, 0.8)
                  : Color.fromRGBO(10, 12, 13, 0.8),
              colorButton: controller.goalRes != "build"
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
                controller.DropButFunction(3, "burn");
              },
              title: "Burn Fat",
              fontSize: 21,
              subText: Text(
                'Burn extra fat & Feel energized',
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'RubikRegular',
                    fontSize: 16,
                    color: controller.goalRes == "burn"
                        ? Color.fromRGBO(10, 12, 13, 0.8)
                        : Color.fromRGBO(255, 255, 255, 0.8)),
              ),
              colorText: controller.goalRes != "burn"
                  ? Color.fromRGBO(255, 255, 255, 0.8)
                  : Color.fromRGBO(10, 12, 13, 0.8),
              colorButton: controller.goalRes != "burn"
                  ? Color.fromRGBO(10, 12, 13, 0.8)
                  : Color.fromRGBO(255, 255, 255, 0.8),
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
    );
  }
}
