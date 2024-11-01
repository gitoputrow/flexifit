import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/profile/controller/ProfileController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ShimmerLoading.dart';

import '../../../../widget/CustomRadioButton.dart';
import '../../../../widget/CustomRadioButtonCircle.dart';

class MyProgramPage extends GetView<ProfileController> {
  const MyProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            child: Text(
              "Goals",
              textScaleFactor: 1,
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'RubikReguler',
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                controller.changeData("goal", "build");
              },
              title: "Build Muscle",
              fontSize: 21,
              isSelected: true,
              subTextTitle: 'Build mass & Strength',
              colorSubText: controller.goalTemp == "build"
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(255, 255, 255, 0.8),
              colorText: controller.goalTemp != "build"
                  ? Colors.white
                  : Color.fromRGBO(255, 255, 255, 1),
              colorButton: controller.goalTemp != "build"
                  ? Color.fromRGBO(255, 255, 255, 0.3)
                  : primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
                onPressed: () {
                  controller.changeData("goal", "burn");
                },
                isSelected: true,
                title: "Burn Fat",
                fontSize: 21,
                subTextTitle: 'Burn extra fat & Feel energized',
                colorSubText: controller.goalTemp == "burn"
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromRGBO(255, 255, 255, 0.8),
                colorText: controller.goalTemp != "burn"
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(255, 255, 255, 1),
                colorButton: controller.goalTemp != "burn"
                    ? Color.fromRGBO(255, 255, 255, 0.3)
                    : primaryColor),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            child: Text(
              "Target Zones",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'RubikReguler',
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                controller.changeData("muscleTarget", "Abs");
              },
              isSelected: true,
              fontSize: 22,
              title: "Abs",
              colorText: !controller.muscleTemp.contains("Abs")
                  ? Colors.white
                  : Color.fromRGBO(255, 255, 255, 1),
              colorButton: !controller.muscleTemp.contains("Abs")
                  ? Color.fromRGBO(255, 255, 255, 0.3)
                  : primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                controller.changeData("muscleTarget", "Arm's");
              },
              fontSize: 22,
              title: "Arms",
              isSelected: true,
              colorText: !controller.muscleTemp.contains("Arm's")
                  ? Color.fromRGBO(255, 255, 255, 0.8)
                  : Color.fromRGBO(255, 255, 255, 1),
              colorButton: !controller.muscleTemp.contains("Arm's")
                  ? Color.fromRGBO(255, 255, 255, 0.3)
                  : primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                controller.changeData("muscleTarget", "Chest");
              },
              isSelected: true,
              fontSize: 22,
              title: "Chest",
              colorText: !controller.muscleTemp.contains("Chest")
                  ? Color.fromRGBO(255, 255, 255, 0.8)
                  : Color.fromRGBO(255, 255, 255, 1),
              colorButton: !controller.muscleTemp.contains("Chest")
                  ? Color.fromRGBO(255, 255, 255, 0.3)
                  : primaryColor
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                controller.changeData("muscleTarget", "Leg's");
              },
              fontSize: 22,
              title: "Legs",
              isSelected: true,
              colorText: !controller.muscleTemp.contains("Leg's")
                  ? Color.fromRGBO(255, 255, 255, 0.8)
                  : Color.fromRGBO(255, 255, 255, 1),
              colorButton: !controller.muscleTemp.contains("Leg's")
                  ? Color.fromRGBO(255, 255, 255, 0.3)
                  : primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Obx(() => ShimmerLoading(
              isLoading: controller.loading,
              child: Text(
                "Workout Per Week",
                textScaleFactor: 1,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'RubikReguler',
                    color: Colors.white),
              ),
            )),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Obx(
              () => ShimmerLoading(
                borderRadiusValue: 32,
                isLoading: controller.loading,
                child: CustomRadioButtonCircle(
                onPressed: () async {
                  controller.changeData("physic", "new");
                  await controller.getUserData();
                },
                title: "3",
                colorText: controller.physicTemp != "new"
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(255, 255, 255, 1),
                colorButton: controller.physicTemp != "new"
                    ? Color.fromRGBO(255, 255, 255, 0.3)
                    : primaryColor,
              ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Obx(
              () => ShimmerLoading(
                borderRadiusValue: 32,
                isLoading: controller.loading,
                child: CustomRadioButtonCircle(
                onPressed: () {
                  controller.changeData("physic", "pro");
                },
                title: "4",
                colorText: controller.physicTemp != "pro"
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(255, 255, 255, 1),
                colorButton: controller.physicTemp != "pro"
                    ? Color.fromRGBO(255, 255, 255, 0.3)
                    : primaryColor,
              ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Obx(() => ShimmerLoading(
              borderRadiusValue: 32,
              isLoading: controller.loading,
              child: CustomRadioButtonCircle(
                  onPressed: () {
                    controller.changeData("physic", "master");
                  },
                  title: "5",
                  colorText: controller.physicTemp != "master"
                      ? Color.fromRGBO(255, 255, 255, 0.8)
                      : Color.fromRGBO(255, 255, 255, 1),
                  colorButton: controller.physicTemp != "master"
                      ? Color.fromRGBO(255, 255, 255, 0.3)
                      : primaryColor,
                ),
            ))
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
