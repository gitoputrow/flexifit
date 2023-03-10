import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/ProgramCard.dart';

class HomePage extends GetView<DashboardController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateFormat('EEEE, d MMMM yyyy').format(DateTime.now())}",
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                fontFamily: 'RubikLight',
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Text(
                              "Hi! ${controller.user.name}",
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'RubikSemiBold',
                                  fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Obx(
                            () => Text(
                              controller.dayTitle,
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.47,
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => PageView(
                pageSnapping: true,
                padEnds: true,
                controller: PageController(viewportFraction: 0.87),
                children: [
                  for (var i = 0; i < controller.programWO.length; i++)
                    GestureDetector(
                          onTap: () async {
                            await controller.getWorkoutList(
                                "${controller.programWO[i].workoutName}");
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 25),
                            child: ProgramCard(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 1.47,
                                imageUrl: controller.programWO[i].picture!,
                                days: controller.programWO[i].day!,
                                WorkoutName: controller.programWO[i].title!),
                          ),
                        )
                ],
              ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
