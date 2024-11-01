import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/workout_challange/controller/WorkoutChallangeDetailController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ChallangeLevelCard.dart';
import 'package:pain/widget/ShimmerLoading.dart';

class ChallangeLevelPage extends GetView<WorkoutChallangeDetailController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  IconButton(
                    icon: Image.asset(
                      "asset/Image/backwo.png",
                      width: 36,
                      height: 36,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Obx(() => ShimmerLoading(
                        isLoading: controller.loading,
                        child: Text(
                          "${controller.loading ? "name" : controller.challangeData.title} Workouts",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'PoppinsBoldSemi',
                              color: Colors.white),
                        ),
                      )),
                  IconButton(
                    icon: Image.asset(
                      "asset/Image/backwo.png",
                      width: 36,
                      height: 36,
                      color: Colors.transparent,
                    ),
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Obx(() => ShimmerLoading(
                        isLoading: controller.loading,
                        child: Text(
                          "Choose your Level!",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'PoppinsRegular',
                              fontSize: 18),
                        ),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Obx(() => ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller.loading
                            ? 2
                            : controller.challangeData.level!.length,
                        itemBuilder: (context, index) => controller.loading
                            ? ShimmerLoading(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width,
                                borderRadiusValue: 20,
                              )
                            : InkWell(
                                onTap: () =>
                                    Get.toNamed("/workoutlist", arguments: {
                                  "workout_data": controller
                                      .challangeData.level![index].workoutData,
                                  "workout_name":
                                      "${controller.challangeData.title}${controller.challangeData.level![index].title}",
                                  "challenge_data":
                                      controller.challangeData.level![index]
                                }),
                                child: ChallangeLevelCard(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  width: MediaQuery.of(context).size.width,
                                  level: controller
                                      .challangeData.level![index].title!,
                                  descLevel: controller
                                      .challangeData.level![index].desc!,
                                  finish: int.parse(controller
                                      .challangeData.level![index].total!),
                                  imageUrl: controller
                                      .challangeData.level![index].picture!,
                                ),
                              ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 30,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
