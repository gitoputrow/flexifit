import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:pain/controller/DashboardController.dart';

import '../../../../widget/CustomRadioButton.dart';
import '../../../../widget/CustomRadioButtonCircle.dart';

class MyProgramPage extends GetView<DashboardController> {
  const MyProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Goals",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
        ),
        SizedBox(
          height: 25,
        ),
        Obx(
          () => CustomRadioButton(
            onPressed: () {
              controller.changeData("goal", "build");
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
                  color: controller.goalTemp == "build"
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(255, 255, 255, 0.8)),
            ),
            colorText: controller.goalTemp != "build"
                ? Color.fromRGBO(255, 255, 255, 0.8)
                : Color.fromRGBO(255, 255, 255, 1),
            colorButton: controller.goalTemp != "build"
                ? Color.fromRGBO(255, 255, 255, 0.3)
                : Color.fromRGBO(205, 5, 27, 0.8),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => CustomRadioButton(
            onPressed: () {
              controller.changeData("goal", "burn");
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
                  color: controller.goalTemp == "burn"
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(255, 255, 255, 0.8)),
            ),
            colorText: controller.goalTemp != "build"
                ? Color.fromRGBO(255, 255, 255, 0.8)
                : Color.fromRGBO(255, 255, 255, 1),
            colorButton: controller.goalTemp != "build"
                ? Color.fromRGBO(255, 255, 255, 0.3)
                : Color.fromRGBO(205, 5, 27, 0.8),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Target Zones",
          style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
        ),
        SizedBox(
          height: 25,
        ),
        Obx(
          () => CustomRadioButton(
            onPressed: () {
              controller.changeData("muscleTarget", "Abs");
            },
            fontSize: 22,
            subText: null,
            title: "Abs",
            colorText: !controller.muscleTemp.contains("Abs")
                ? Colors.white
                : Color.fromRGBO(255, 255, 255, 1),
            colorButton: !controller.muscleTemp.contains("Abs")
                ? Color.fromRGBO(255, 255, 255, 0.3)
                : Color.fromRGBO(205, 5, 27, 0.8),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => CustomRadioButton(
            onPressed: () {
              controller.changeData("muscleTarget", "Arm's");
            },
            fontSize: 22,
            subText: null,
            title: "Arms",
            colorText: !controller.muscleTemp.contains("Arm's")
                ? Color.fromRGBO(255, 255, 255, 0.8)
                : Color.fromRGBO(255, 255, 255, 1),
            colorButton: !controller.muscleTemp.contains("Arm's")
                ? Color.fromRGBO(255, 255, 255, 0.3)
                : Color.fromRGBO(205, 5, 27, 0.8),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => CustomRadioButton(
            onPressed: () {
              controller.changeData("muscleTarget", "Chest");
            },
            fontSize: 22,
            subText: null,
            title: "Chest",
            colorText: !controller.muscleTemp.contains("Chest")
                ? Color.fromRGBO(255, 255, 255, 0.8)
                : Color.fromRGBO(255, 255, 255, 1),
            colorButton: !controller.muscleTemp.contains("Chest")
                ? Color.fromRGBO(255, 255, 255, 0.3)
                : Color.fromRGBO(205, 5, 27, 0.8),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => CustomRadioButton(
            onPressed: () {
              controller.changeData("muscleTarget", "Leg's");
            },
            fontSize: 22,
            subText: null,
            title: "Legs",
            colorText: !controller.muscleTemp.contains("Leg's")
                ? Color.fromRGBO(255, 255, 255, 0.8)
                : Color.fromRGBO(255, 255, 255, 1),
            colorButton: !controller.muscleTemp.contains("Leg's")
                ? Color.fromRGBO(255, 255, 255, 0.3)
                : Color.fromRGBO(205, 5, 27, 0.8),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Workout Per Week",
          textScaleFactor: 1,
          style: TextStyle(fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Obx(
              () => CustomRadioButtonCircle(
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
                    : Color.fromRGBO(205, 5, 27, 0.8),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Obx(
              () => CustomRadioButtonCircle(
                onPressed: () {
                  controller.changeData("physic", "pro");

                  final x = DateFormat('dd/MM/y_H:mm:ss').format(DateTime.now());
                  print(x);
                  Timer.periodic(Duration(seconds: 2), (_) {
                    print(x);
                    _.cancel();
                  });
                },
                title: "4",
                colorText: controller.physicTemp != "pro"
                    ? Color.fromRGBO(255, 255, 255, 0.8)
                    : Color.fromRGBO(255, 255, 255, 1),
                colorButton: controller.physicTemp != "pro"
                    ? Color.fromRGBO(255, 255, 255, 0.3)
                    : Color.fromRGBO(205, 5, 27, 0.8),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Obx(() => CustomRadioButtonCircle(
                  onPressed: () {
                    controller.changeData("physic", "master");
                  },
                  title: "5",
                  colorText: controller.physicTemp != "master"
                      ? Color.fromRGBO(255, 255, 255, 0.8)
                      : Color.fromRGBO(255, 255, 255, 1),
                  colorButton: controller.physicTemp != "master"
                      ? Color.fromRGBO(255, 255, 255, 0.3)
                      : Color.fromRGBO(205, 5, 27, 0.8),
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
