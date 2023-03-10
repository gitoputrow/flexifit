import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';

import '../../../widget/ButtonCustomMain.dart';

class WorkoutStartPage extends GetView<DashboardController> {
  const WorkoutStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
              child: Stack(
                children: [
                  Obx(
                    () => Image.network(
                      controller.workoutData.data![controller.workoutIndex].previewPicture!,
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "image_not_found",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(170, 5, 27, 1),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: IconButton(
                      icon: Image.asset("asset/Image/backwo.png"),
                      iconSize: 40,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              padding: EdgeInsets.only(right: 35),
              alignment: Alignment.centerRight,
              child: Obx(
                () => Text(
                  "${controller.workoutIndex + 1} of ${controller.workoutData.data!.length}",
                  style: TextStyle(fontSize: 22, color: Colors.white, fontFamily: 'RubikLight'),
                ),
              )),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  "${controller.workoutData.data![controller.workoutIndex].title}",
                  style: TextStyle(fontSize: 27, color: Colors.white, fontFamily: 'RubikSemiBold'),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "x ${controller.workoutData.reps}",
                style: TextStyle(fontSize: 22, color: Colors.white, fontFamily: 'RubikLight'),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
                    child: Obx(() => ButtonCustomMain(
                        onPressed: () {
                          if (controller.workoutIndex != controller.workoutData.data!.length - 1) {
                            controller.runbacktime();
                            controller.workoutIndex += 1;
                            Get.toNamed("/workoutrest");
                          } else {
                            Get.toNamed("/workoutfinish");
                            controller.workoutIndex = 0;
                            controller.restTime = 30;
                          }
                        },
                        alignText: Alignment.center,
                        borderRadius: 30,
                        colorText: Colors.white,
                        title: controller.workoutIndex != controller.workoutData.data!.length - 1
                            ? "Continue"
                            : "Finish",
                        primary: Color.fromARGB(255, 138, 4, 22),
                        permission: true))),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
