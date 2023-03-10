import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/ChallangeLevelCard.dart';

class ChallangeLevelPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 21,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Image.asset("asset/Image/backwo.png"),
                        iconSize: 36,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 9.5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${controller.challangeData[controller.challangeIndex].title} Workouts",
                        style: TextStyle(
                            fontSize: 22, fontFamily: 'PoppinsBoldSemi', color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Choose your Level!",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  for (int i = 0; i < 2; i++)
                    Column(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () async => await controller.getWorkoutList(
                                "${controller.challangeData[controller.challangeIndex].title}${controller.challangeData[controller.challangeIndex].level![i].title!}"),
                            child: ChallangeLevelCard(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width,
                              level: controller
                                  .challangeData[controller.challangeIndex].level![i].title!,
                              descLevel: controller
                                  .challangeData[controller.challangeIndex].level![i].desc!,
                              finish: controller.finishedChallange[i],
                              imageUrl: controller
                                  .challangeData[controller.challangeIndex].level![i].picture!,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
