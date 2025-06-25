import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/workout/controller/WorkoutListController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/ShimmerLoading.dart';
import 'package:pain/feature/workout/view/widgets/WorkoutListCard.dart';

class WorkoutListPage extends GetView<WorkoutListController> {
  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: Stack(
          children: [
            LiquidPullToRefresh(
              onRefresh: () => controller.getWorkoutList(),
              backgroundColor: primaryColor,
              color: backgroundColor,
              showChildOpacityTransition: false,
              height: 140,
              borderWidth: 4,
              springAnimationDurationInMilliseconds: 1000,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      child: Stack(
                        children: [
                          Obx(() => controller.loading
                              ? ShimmerLoading(
                                  isLoading: true,
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  width: MediaQuery.of(context).size.width,
                                )
                              : CachedNetworkImage(
                                  imageUrl: controller.workoutData.picture!,
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
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
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return ShimmerLoading(
                                      isLoading: true,
                                    );
                                  },
                                )),
                          Padding(
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
                    height: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => ShimmerLoading(
                            isLoading: controller.loading,
                            child: Text(
                              "${controller.loading ? "workout title" : controller.workoutData.title} Workout",
                              style: TextStyle(
                                  fontFamily: 'RubikSemiBold',
                                  fontSize: 32,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Obx(() => ShimmerLoading(
                              isLoading: controller.loading,
                              child: Text(
                                "with ${controller.workoutData.data!.length} workouts",
                                style: TextStyle(
                                    fontFamily: 'RubikLight',
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() => ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 120),
                            itemBuilder: (context, index) => WorkoutListCard(
                                  isLoading: controller.loading,
                                  imageUrl: controller
                                      .workoutData.data?[index].picture,
                                  reps: controller.workoutData.reps,
                                  workout_title:
                                      controller.workoutData.data?[index].title,
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 30,
                                ),
                            itemCount: controller.loading
                                ? 4
                                : controller.workoutData.data!.length)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Obx(() => controller.loading
                ? SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 4),
                          child: ButtonCustomMain(
                              onPressed: () {
                                Get.toNamed("/workoutstart", arguments: {
                                  "workout_name": controller.workoutName,
                                  "workout_data": controller.workoutData,
                                  "challenge_id": controller.idChallenge,
                                  "challenge_level_title":
                                      controller.levelChallengeName
                                });
                              },
                              title: "Start",
                              permission: true)),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
