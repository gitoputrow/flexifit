import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/workout/controller/WorkoutProgressController.dart';
import 'package:pain/widget/ShimmerLoading.dart';
import '../../../widget/CustomButton.dart';

class WorkoutStartPage extends GetView<WorkoutProgressController> {
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
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              child: Stack(
                children: [
                  Obx(
                    () => CachedNetworkImage(
                      imageUrl: controller.workoutData
                          .data![controller.workoutIndex].previewPicture!,
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
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
                      progressIndicatorBuilder: (context, url, progress) {
                        return ShimmerLoading(
                          isLoading: true,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: IconButton(
                      icon: Image.asset(
                        "asset/Image/backwo.png",
                        width: 40,
                        height: 40,
                      ),
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
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: 'RubikLight'),
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
                  style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontFamily: 'RubikSemiBold'),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "x ${controller.workoutData.reps}",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontFamily: 'RubikLight'),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 4),
                    child: Obx(() => ButtonCustomMain(
                        onPressed: () {
                          if (controller.workoutIndex !=
                              controller.workoutData.data!.length - 1) {
                            controller.runbacktime();
                            controller.workoutIndex += 1;
                            Get.toNamed("/workoutrest");
                          } else {
                            Get.offNamedUntil("/workoutfinish", (route) {
                              return route.settings.name == "/challangelevel" ||
                                  route.settings.name == "/dashboard";
                            }, arguments: {
                              'workout_name': controller.workoutName,
                              "challenge_id": controller.idChallenge,
                              "challenge_level_title":
                                  controller.levelChallengeName
                            });

                            controller.workoutIndex = 0;
                            controller.restTime = 30;
                          }
                        },
                        alignText: Alignment.center,
                        borderRadius: 30,
                        title: controller.workoutIndex !=
                                controller.workoutData.data!.length - 1
                            ? "Continue"
                            : "Finish",
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
