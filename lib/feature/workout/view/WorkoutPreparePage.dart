import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutPreparePage extends StatefulWidget {
  const WorkoutPreparePage({super.key});

  @override
  State<WorkoutPreparePage> createState() => _WorkoutPreparePageState();
}

class _WorkoutPreparePageState extends State<WorkoutPreparePage>
    with SingleTickerProviderStateMixin {
  int second = 11;
  Timer? timer;

  // final controller = Get.find<WorkoutController>();\

  dynamic argumentData = Get.arguments;

  late AnimationController controller_;
  @override
  void initState() {
    controller_ = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10090),
    )..addListener(() {
        setState(() {});
      });
    Timer(Duration(milliseconds: 11150), () {
      Get.offNamed("/workoutstart");
    });
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        second--;
      });
      if (second == 0) {
        timer?.cancel();
        controller_.stop();
      } else if (second == 10) {
        controller_.repeat(reverse: true);
      }
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   setState(() {
  //   timer?.cancel();
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(10, 12, 13, 1),
          body: Stack(
            children: [
              Center(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.7,
                child: CircularProgressIndicator(
                  value: controller_.value,
                  color: Color.fromRGBO(10, 12, 13, 1),
                  backgroundColor:
                      second == 0 ? Color.fromRGBO(10, 12, 13, 1) : Color.fromRGBO(205, 5, 27, 1),
                  semanticsLabel: 'Linear progress indicator',
                  strokeWidth: 25,
                ),
              )),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Prepare your self",
                      style: TextStyle(
                          fontFamily: 'RubikMedium',
                          fontSize: 23,
                          color: Color.fromRGBO(255, 255, 255, 0.8)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "for ${argumentData['title']}’s workout",
                      style: TextStyle(
                          fontFamily: 'RubikReguler',
                          fontSize: 19,
                          color: Color.fromRGBO(255, 255, 255, 0.8)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (second >= 10)
                      Text(
                        "00:10",
                        style: TextStyle(
                            fontFamily: 'RubikMedium',
                            fontSize: 34,
                            color: Color.fromRGBO(205, 5, 27, 1)),
                      ),
                    if (second < 10)
                      Text(
                        "00:0$second",
                        style: TextStyle(
                            fontFamily: 'RubikMedium',
                            fontSize: 34,
                            color: Color.fromRGBO(205, 5, 27, 1)),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
