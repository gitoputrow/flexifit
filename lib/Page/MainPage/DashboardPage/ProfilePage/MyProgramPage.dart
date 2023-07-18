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
                      condition: controller.goalTemp != "build",
                      unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                      selectedText: Color.fromRGBO(255, 255, 255, 1),
                      unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                      selectedBut: Color.fromRGBO(205, 5, 27, 0.8),
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
                        condition: controller.goalTemp != "burn",
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
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
                        condition: !controller.muscleTemp.contains("Abs"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
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
                        condition: !controller.muscleTemp.contains("Arm's"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
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
                        condition: !controller.muscleTemp.contains("Chest"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
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
                        condition: !controller.muscleTemp.contains("Leg's"),
                        unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                        selectedText: Color.fromRGBO(255, 255, 255, 1),
                        unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                        selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
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
                            condition: controller.physicTemp != "new",
                            unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                            selectedText: Color.fromRGBO(255, 255, 255, 1),
                            unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                            selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
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
                            condition: controller.physicTemp != "pro",
                            unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                            selectedText: Color.fromRGBO(255, 255, 255, 1),
                            unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                            selectedBut: Color.fromRGBO(205, 5, 27, 0.8)),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Obx(() => CustomRadioButtonCircle(
                          onPressed: () {
                            controller.changeData("physic", "master");
                          },
                          title: "5",
                          condition: controller.physicTemp != "master",
                          unSelectedText: Color.fromRGBO(255, 255, 255, 0.8),
                          selectedText: Color.fromRGBO(255, 255, 255, 1),
                          unSelectedBut: Color.fromRGBO(255, 255, 255, 0.3),
                          selectedBut: Color.fromRGBO(205, 5, 27, 0.8)))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
      ],
    );
  }
}