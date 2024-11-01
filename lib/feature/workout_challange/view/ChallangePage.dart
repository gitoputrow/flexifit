import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/workout_challange/controller/WorkoutChallangeController.dart';
import 'package:pain/model/CalisthenicsPark.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/BasicLoader.dart';
import 'package:pain/widget/ChallangeCard.dart';
import 'package:pain/widget/CustomeTabBar.dart';
import 'package:pain/widget/PlaceCard.dart';
import 'package:pain/widget/ShimmerLoading.dart';

class ChallangePage extends GetView<WorkoutChallangeController> {
  const ChallangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                        "Workouts Challange",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PoppinsBoldSemi',
                            color: Colors.white),
                      ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  endIndent: MediaQuery.of(context).size.width / 1.95,
                  thickness: 2,
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                ),
                  SizedBox(
                  height: 5,
                ),
                const Text(
                  "Try Our Challange",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ])),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: LiquidPullToRefresh(
                    backgroundColor: primaryColor,
                    showChildOpacityTransition: false,
                    color: backgroundColor,
                    height: 140,
                    onRefresh: () async =>
                        await controller.getChallengeData(),
                    child: Obx(() => ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          // controller.challangeIndex = index;
                          // await controller.getFinishedData();
                          Get.toNamed("/challangelevel", arguments: {
                            "title": controller.challangeData[index].title
                          });
                        },
                        child: controller.loading
                            ? ShimmerLoading(
                                height: 125,
                                borderRadiusValue: 20,
                              )
                            : ChallangeCard(
                                height: 125,
                                challangeData: controller.challangeData[index],
                                width: MediaQuery.of(context).size.width),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 35,
                      ),
                  itemCount:
                      controller.loading ? 4 : controller.challangeData.length)),
            ),
          )
        ]));
  }
}
