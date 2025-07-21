import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/workout/controller/WorkoutFinishController.dart';
import '../../../theme/colors.dart';
import '../../../widget/CustomButton.dart';
import '../controller/WorkoutProgressController.dart';

class WorkoutFinishPage extends GetView<WorkoutFinishController> {
  const WorkoutFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(10, 12, 13, 1),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/Image/DoneImage.png",
                  width: 290,
                  height: 260,
                ),
                Text(
                  "Well Done! You Are Great",
                  style: TextStyle(
                      fontFamily: 'RubikReguler',
                      fontSize: 23,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ButtonCustomMain(
                      onPressed: () async {
                        await controller.finishWorkout();
                      },
                      alignText: Alignment.center,
                      borderRadius: 30,
                      colorText: Colors.white,
                      title: "Finish",
                      primary: primaryColor,
                      permission: true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
