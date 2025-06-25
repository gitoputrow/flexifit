import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/feature/MainController.dart';
import 'package:pain/feature/profile/controller/ProfileController.dart';
import 'package:pain/feature/profile/view/widgets/MyProfilePage.dart';

import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/MediaWidget.dart';
import 'package:pain/widget/CustomAlertDialog.dart';
import 'package:pain/widget/CustomRadioButton.dart';
import 'package:pain/widget/CustomRadioButtonCircle.dart';
import 'package:pain/widget/ProgramCard.dart';
import 'package:pain/widget/ShimmerLoading.dart';

import '../../../theme/colors.dart';
import '../../../widget/CustomButton.dart';
import 'widgets/GoalsWidget.dart';
import 'widgets/SocialMediaSummaryCard.dart';
import 'widgets/TargetZoneWidget.dart';
import 'widgets/WorkoutPerWeekWidget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 12, 13, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Stack(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'PoppinsBoldSemi',
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      endIndent: MediaQuery.of(context).size.width / 1.95,
                      thickness: 2,
                      color: const Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "See Your Own Program",
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    child: Image.asset(
                      "asset/Image/settingprofile.png",
                      width: 44,
                      height: 44,
                    ),
                    onTap: () async {
                      if (controller.changeDataCheck) {
                        await controller.changeProgram(toSettingPage: true);
                        return;
                      }
                      Get.toNamed("/settingpage", arguments: controller.user);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: LiquidPullToRefresh(
                backgroundColor: primaryColor,
                showChildOpacityTransition: false,
                color: backgroundColor,
                springAnimationDurationInMilliseconds: 500,
                height: 140,
                onRefresh: () async => await controller.getUserData(),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Goals",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'RubikReguler',
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => GoalsWidget(
                        goalValue: controller.goalTemp,
                        onChange: (section, value) {
                          controller.changeData(section, value);
                        },
                        isLoading: controller.loading,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Target Zones",
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'RubikReguler',
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(() => TargetZoneWidget(
                        muscleValue: controller.muscleTemp.toList(),
                        onChange: (section, value) {
                          controller.changeData(section, value);
                        },
                        isLoading: controller.loading)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Workout Per Week",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'RubikReguler',
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Obx(
                          () => WorkoutPerWeekWidget(
                              physicValue: controller.physicTemp,
                              onChange: (section, value) {
                                controller.changeData(section, value);
                              },
                              isLoading: controller.loading),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "My Social Media",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'RubikReguler',
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // ShimmerLoading(
                    //   isLoading: controller.loading,
                    //   child: ButtonCustomMain(
                    //     primary: Colors.white,
                    //     colorText: Colors.black,
                    //   onPressed: () {
                    //     Get.toNamed("/userprofilepage",
                    //         arguments: {"id": controller.user.id});
                    //   },
                    //   title: "My Social Media Profile",
                    //   borderRadius: 16,
                    //   padding: EdgeInsets.all(16),
                    // ),
                    // ),
                    Obx(() => SocialMediaSummaryCard(
                        data: controller.user, isLoading: controller.loading)),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
