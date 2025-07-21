import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pain/feature/profile/controller/ProfileController.dart';
import 'package:pain/feature/workout_program/controller/WorkoutProgramController.dart';
import 'package:pain/services/update/update_services.dart';

import '../widget/BasicLoader.dart';
import '../widget/CustomAlertDialog.dart';
import 'places/views/WorkoutPlacesPageView.dart';
import 'profile/view/ProfilePage.dart';
import 'social_media/view/SosmedPage.dart';
import 'challenge/view/ChallangePage.dart';
import 'workout_program/view/WorkoutProgramPage.dart';

class MainController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Widget> pages = [
    WorkoutProgramPage(),
    ChallangePage(),
    WorkoutPlacesPageView(),
    SosmedPage(),
    ProfilePage()
  ];

  Rx<int> _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int currentIndex) => _currentIndex.value = currentIndex;

  @override
  void onInit() async {
    await UpdateServices().getUpdateStatus();
    super.onInit();
  }

  void changePage(int index) async {
    if (Get.isRegistered<ProfileController>()) {
      ProfileController cProfile = Get.find();
      if (cProfile.changeDataCheck) {
        await changeUserProgram(index: index);
        return;
      }
    }
    currentIndex = index;
  }

  Future changeUserProgram({int? index}) async {
    ProfileController cProfile = Get.find();
    if (cProfile.changeDataCheck) {
      Get.dialog(CustomAlertDialog(
          onPressedno: () {
            Get.back();
            cProfile.resetData();
            currentIndex = index ?? currentIndex;
          },
          onPressedyes: () async {
            Get.back();
            currentIndex = index ?? currentIndex;
            cProfile.changeDataCheck = false;
            WorkoutProgramController cWorkoutProgram = Get.find();
            try {
              cWorkoutProgram.loading = true;
              await cProfile.changeProgram();
              await cWorkoutProgram.getUserData();
              await Future.wait([
                cWorkoutProgram.getBodyInformation(),
                cWorkoutProgram.getProgramData()
              ]);
              cWorkoutProgram.loading = false;
            } catch (e) {
              log(e.toString());
            }
          },
          backgroundColor: Color.fromRGBO(69, 63, 63, 0.773),
          title: "Do you want to Change Your Program?",
          fontColor: Color.fromARGB(204, 255, 255, 255),
          fontSize: 20,
          iconColor: Colors.white));
    } else {}
  }
}
