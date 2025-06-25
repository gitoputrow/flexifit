import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/MainController.dart';
import 'package:pain/feature/authentification/view/HomeScreen.dart';

import '../../../StorageProvider.dart';
import '../../../widget/CustomAlertDialog.dart';
import '../../authentification/models/UserData.dart';
import '../../../widget/ToastMessageCustom.dart';
import '../../workout_program/controller/WorkoutProgramController.dart';

class ProfileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();

  final List<String> items = [
    "My Program",
    "My Profile",
  ];

  Rx<String> _selectedValue = "My Program".obs;
  String get selectedValue => _selectedValue.value;
  set selectedValue(String selectedValue) =>
      _selectedValue.value = selectedValue;

  Rx<UserData> _user = UserData().obs;
  UserData get user => _user.value;
  set user(UserData user) => _user.value = user;

  Rx<String> _goalTemp = "".obs;
  String get goalTemp => _goalTemp.value;
  set goalTemp(String goalTemp) => _goalTemp.value = goalTemp;

  Rx<String> _physicTemp = "".obs;
  String get physicTemp => _physicTemp.value;
  set physicTemp(String physicTemp) => _physicTemp.value = physicTemp;

  RxList<String> _muscleTemp = <String>[].obs;
  List<String> get muscleTemp => _muscleTemp;
  set muscleTemp(List<String> muscleTemp) => _muscleTemp.value = muscleTemp;

  RxList<String> _muscle = <String>[].obs;
  List<String> get muscle => _muscle.value;
  set muscle(List<String> muscle) => _muscle.value = muscle;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  String? userid;

  bool changeDataCheck = false;

  Future getUserData() async {
    loading = true;
    try {
      final data = await firestore.collection("usersData").doc(userid).get();
      user = UserData.fromJson(json.decode(json.encode(data.data())));
      resetData();
    } catch (e) {
      Get.offAll(HomeScreen());
    }
    loading = false;
  }

  void resetData() {
    goalTemp = user.goal!;
    physicTemp = user.physical!;
    muscleTemp.clear();
    muscle.clear();
    for (int i = 0; i < user.targetMuscle!.length; i++) {
      muscleTemp.add(user.targetMuscle![i]);
      muscle.add(user.targetMuscle![i]);
    }
    muscle.sort();
    muscleTemp.sort();
    changeDataCheck = false;
  }

  void changeData(String section, String value) {
    if (section == "goal") {
      goalTemp = value;
    } else if (section == "muscleTarget") {
      if (muscleTemp.contains(value)) {
        if (muscleTemp.length == 1) {
          ToastMessageCustom.ToastMessage("you have to select at least one",
              Color.fromRGBO(10, 12, 13, 0.8));
        } else {
          muscleTemp.remove(value);
        }
      } else {
        muscleTemp.add(value);
        muscleTemp.sort();
      }
    } else if (section == "physic") {
      physicTemp = value;
    }

    changeDataCheck = goalTemp != user.goal ||
        physicTemp != user.physical ||
        muscleTemp != user.targetMuscle;
  }

  Future changeProgram(
      {bool toSettingPage = false, bool toProfilePage = false}) async {
    dynamic result;
    if (toSettingPage || toProfilePage) {
      result = await Get.dialog(CustomAlertDialog(
          onPressedno: () {
            Get.back();
            resetData();
          },
          onPressedyes: () async {
            Get.back(result: true);
          },
          backgroundColor: Color.fromRGBO(69, 63, 63, 0.773),
          title: "Do you want to Change Your Program?",
          fontColor: Color.fromARGB(204, 255, 255, 255),
          fontSize: 20,
          iconColor: Colors.white));
    }
    if (toSettingPage) {
      Get.toNamed("/settingpage", arguments: user);
    }
    if (result != null || (!toProfilePage && !toSettingPage)) {
      try {
        log("masuk await profile");
        await firestore.collection("usersData").doc(userid).update({
          "physical": physicTemp,
          "goal": goalTemp,
          "target_muscle": List<Map>.from(muscleTemp.map(
            (e) => {"muscle": e},
          )),
        });
        await getUserData();
        if (toProfilePage || toSettingPage) {
          log("masuk await program");
          WorkoutProgramController c = Get.find();
          await c.getUserData();
          Future.wait([
            c.getBodyInformation(),
            c.getProgramData(),
          ]);
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  void onInit() async {
    userid = await StorageProvider.getUserToken();
    if (userid == null) {
      Get.to(() => HomeScreen());
    }
    await getUserData();
    
    super.onInit();
  }
}
