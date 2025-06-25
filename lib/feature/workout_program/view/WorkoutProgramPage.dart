import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/feature/workout_program/controller/WorkoutProgramController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/BodyInformationContent.dart';
import 'package:pain/widget/ProgramCard.dart';
import 'package:pain/widget/ShimmerLoading.dart';

class WorkoutProgramPage extends GetView<WorkoutProgramController> {
  const WorkoutProgramPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                        isLoading: controller.loading,
                        child: Text(
                          controller.loading
                              ? "Tanggal Hari ini"
                              : "${DateFormat('EEEE, d MMMM yyyy').format(DateTime.now())}",
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.75),
                              fontFamily: 'RubikLight',
                              fontSize: 16),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ShimmerLoading(
                      isLoading: controller.loading,
                      child: Text(
                        "Hi! ${controller.loading ? "Nama User" : controller.user.name}",
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'RubikSemiBold',
                            fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ShimmerLoading(
                      width: MediaQuery.sizeOf(context).width / 3.3,
                      isLoading: controller.loading,
                      height: 23,
                      child: Text(
                        controller.loading
                            ? "title day is activity"
                            : controller.dayTitle,
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'PoppinsRegular',
                            fontSize: 16),
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: LiquidPullToRefresh(
              backgroundColor: primaryColor,
              showChildOpacityTransition: false,
              color: backgroundColor,
              height: 140,
              onRefresh: () async {
                controller.loading = true;
                controller.getUserData();
                await Future.wait([
                  controller.getProgramData(),
                  controller.getBodyInformation(),
                ]);
                controller.loading = false;
              },
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.width,
                      child: Obx(
                        () => ShimmerLoading(
                            isLoading: controller.loading,
                            borderRadiusValue: 20,
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: PageView(
                              physics: BouncingScrollPhysics(),
                              pageSnapping: true,
                              padEnds: true,
                              controller:
                                  PageController(viewportFraction: 0.85),
                              children: [
                                for (var i = 0;
                                    i < controller.programWO.length;
                                    i++)
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/workoutlist", arguments: {
                                        "workout_name":
                                            controller.programWO[i].workoutName,
                                        "workout_data":
                                            controller.programWO[i].workoutData,
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 25),
                                      child: ProgramCard(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.7,
                                        programWO: controller.programWO[i],
                                      ),
                                    ),
                                  )
                              ],
                            )),
                      )),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Body Information",
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'RubikSemiBold',
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: tertiaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Obx(() => ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      BodyInformationContent(
                                          data: controller.bodyInformation
                                              .information?[index]),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 16),
                                  itemCount: controller.bodyInformation
                                          .information?.length ??
                                      3,
                                )))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
