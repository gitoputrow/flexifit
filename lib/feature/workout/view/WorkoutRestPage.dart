import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/workout/controller/WorkoutProgressController.dart';
import 'package:pain/theme/colors.dart';
import '../../../widget/CustomButton.dart';

class WorkoutRestPage extends GetView<WorkoutProgressController> {
  const WorkoutRestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(10, 12, 13, 1),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rest",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontFamily: 'RubikMedium',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Next is ${controller.workoutData.data![controller.workoutIndex].title} ${controller.workoutData.reps} x",
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.6),
                  fontSize: 24,
                  fontFamily: 'RubikReguler',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Obx(
                () => Text(
                controller.formatTime(),
                style: TextStyle(
                    fontFamily: 'RubikMedium', fontSize: 38, color: Color.fromRGBO(205, 5, 27, 1)),
              ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ButtonCustomMain(
                              onPressed: () {
                                controller.restTime += 10;
                              },
                              alignText: Alignment.center,
                        borderRadius: 30,
                              title: "+10s",
                              colorText: Colors.black,
                              primary: Colors.white,
                              permission: true),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ButtonCustomMain(
                              onPressed: () {
                                controller.timer!.cancel();
                                controller.restTime = 30;
                                Get.back();
                              },
                              alignText: Alignment.center,
                        borderRadius: 30,
                              colorText: Colors.white,
                              title: "Skip",
                              primary: primaryColor,
                              permission: true),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
