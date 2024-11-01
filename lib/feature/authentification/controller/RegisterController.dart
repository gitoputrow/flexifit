import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:pain/StorageProvider.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ToastMessageCustom.dart';

import '../../../widget/BasicLoader.dart';
import '../view/RegisterPageStep/RegistPageStep1.dart';
import '../view/RegisterPageStep/RegistPageStep2.dart';
import '../view/RegisterPageStep/RegistPageStep3.dart';
import '../view/RegisterPageStep/RegistPageStep4.dart';
import '../view/RegisterPageStep/RegistPageStep5.dart';
import '../view/RegisterPageStep/RegistPageStep6.dart';
import '../view/RegisterPageStep/RegistPageStep7.dart';

class RegisterController extends GetxController {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final storageRef = FirebaseStorage.instance.ref();

  String urlPhoto = "";

  final GlobalKey<FormBuilderState> formProfile = GlobalKey();
  final GlobalKey<FormBuilderState> formAccount = GlobalKey();

  Map<String, dynamic> payload = {};

  Rx<int> _indexRegist = 0.obs;
  int get indexRegist => _indexRegist.value;
  set indexRegist(int indexRegist) => _indexRegist.value = indexRegist;

  Rx<bool> _continuePermission = false.obs;
  bool get continuePermission => _continuePermission.value;
  set continuePermission(bool continuePermission) =>
      _continuePermission.value = continuePermission;

  Rx<String> _genderRes = "".obs;
  String get genderRes => _genderRes.value;
  set genderRes(String genderRes) => _genderRes.value = genderRes;

  Rx<String> _goalRes = "".obs;
  String get goalRes => _goalRes.value;
  set goalRes(String goalRes) => _goalRes.value = goalRes;

  Rx<String> _physicalRes = "".obs;
  String get physicalRes => _physicalRes.value;
  set physicalRes(String physicalRes) => _physicalRes.value = physicalRes;

  RxList<String> _motivRes = <String>[].obs;
  List<String> get motivRes => _motivRes;
  set motivRes(List<String> motivRes) => _motivRes.value = motivRes;

  RxList<String> _targetRes = <String>[].obs;
  List<String> get targetRes => _targetRes;
  set targetRes(List<String> targetRes) => _targetRes.value = targetRes;

  Rx<bool> _passResistVisble = false.obs;
  bool get passResistVisble => _passResistVisble.value;
  set passResistVisble(bool passResistVisble) =>
      _passResistVisble.value = passResistVisble;

  Rx<bool> _cpassResistVisble = false.obs;
  bool get cpassResistVisble => _cpassResistVisble.value;
  set cpassResistVisble(bool cpassResistVisble) =>
      _cpassResistVisble.value = cpassResistVisble;

  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> age = TextEditingController().obs;
  Rx<TextEditingController> weight = TextEditingController().obs;
  Rx<TextEditingController> height = TextEditingController().obs;
  Rx<TextEditingController> username = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> cpassword = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;

  List<Image> pagination = [
    Image.asset(
      "asset/Image/Pagination/pagination1.png",
      scale: 6,
    ),
    Image.asset(
      "asset/Image/Pagination/pagination2.png",
      scale: 6,
    ),
    Image.asset(
      "asset/Image/Pagination/pagination3.png",
      scale: 6,
    ),
    Image.asset(
      "asset/Image/Pagination/pagination4.png",
      scale: 6,
    ),
    Image.asset(
      "asset/Image/Pagination/pagination5.png",
      scale: 6,
    ),
    Image.asset(
      "asset/Image/Pagination/pagination6.png",
      scale: 6,
    ),
    Image.asset(
      "asset/Image/Pagination/pagination7.png",
      scale: 6,
    ),
  ];

  List<Widget> stepPage = [
    RegistPageStep1(),
    RegistPageStep2(),
    RegistPageStep3(),
    RegistPageStep4(),
    RegistPageStep5(),
    RegistPageStep6(),
    RegistPageStep7()
  ];

  List<String> registButTitle = ["Continue", "Finish", "Let's Get Fit"];

  void continueRegistFunc() {
    if (indexRegist == 0) {
      continuePermission = genderRes != "";
    } else if (indexRegist == 1) {
      continuePermission = physicalRes != "";
    } else if (indexRegist == 2) {
      continuePermission = goalRes != "";
    } else if (indexRegist == 3) {
      continuePermission = motivRes.isNotEmpty;
    } else if (indexRegist == 4) {
      continuePermission = targetRes.isNotEmpty;
    } else if (indexRegist == 5) {
      continuePermission = name.value.text != "" &&
          age.value.text != "" &&
          weight.value.text != "" &&
          height.value.text != "";
    } else if (indexRegist == 6) {
      continuePermission = email.value.text != "" &&
          username.value.text != "" &&
          password.value.text != "" &&
          cpassword.value.text != "";
    }
  }

  Future<bool> checkUsername(String username) async {
    final data = await firestore
        .collection("usersData")
        .where('username', isEqualTo: username)
        .get();
    if (data.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future regist() async {
    Get.dialog(BasicLoader());

    payload.removeWhere((key, value) => key == "pass_confirm");
    payload.removeWhere((key, value) => key == "pass");

    List<Map<String, dynamic>> muscledata = [];
    if (physicalRes == "newb") {
      physicalRes = "new";
    }
    targetRes.sort();
    for (var i = 0; i < targetRes.length; i++) {
      muscledata.add({"muscle": targetRes[i]});
    }

    Map<String, dynamic> dataUser = {
      "gender": genderRes,
      "goal": goalRes,
      "physical": physicalRes,
      ...payload,
      "like": 0,
      "target_muscle": muscledata,
      "dislike": 0,
      "post": 0,
      "photo_profile": urlPhoto,
      "challenge_data": {
        "Full BodyBeginner": 0,
        "AbsBeginner": 0,
        "TricepsBeginner": 0,
        "BicepsBeginner": 0,
        "ChestBeginner": 0,
        "LegsBeginner": 0,
        "CardioBeginner": 0,
        "Full BodyIntermediate": 0,
        "AbsIntermediate": 0,
        "TricepsIntermediate": 0,
        "BicepsIntermediate": 0,
        "ChestIntermediate": 0,
        "LegsIntermediate": 0,
        "CardioIntermediate": 0,
      }
    };

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: formAccount.currentState!.value['email'],
          password: formAccount.currentState!.value['pass']);
      final usernameExist =
          await checkUsername(formAccount.currentState!.value['username']);
      if (usernameExist == true) {
        Get.back();
        ToastMessageCustom.ToastMessage(
            "Username already taken", Color.fromARGB(204, 245, 60, 13));
      } else {
        try {
          await firestore.collection('usersData').add(dataUser).then((value) async => await StorageProvider.setUserToken(value.id));
          // await database
          //     .child("userDatabase")
          //     .child("$id")
          //     .set(dataUser)
          //     .whenComplete(() => database
          //         .child("userDatabase")
          //         .child("$id")
          //         .child("targetMuscle")
          //         .set(muscledata)
          //         .whenComplete(() => database
          //                 .child("userDatabase")
          //                 .child("$id")
          //                 .child("challengeData")
          //                 .set({
          //               "Full BodyBeginner": 0,
          //               "AbsBeginner": 0,
          //               "TricepsBeginner": 0,
          //               "BicepsBeginner": 0,
          //               "ChestBeginner": 0,
          //               "LegsBeginner": 0,
          //               "CardioBeginner": 0,
          //               "Full BodyIntermediate": 0,
          //               "AbsIntermediate": 0,
          //               "TricepsIntermediate": 0,
          //               "BicepsIntermediate": 0,
          //               "ChestIntermediate": 0,
          //               "LegsIntermediate": 0,
          //               "CardioIntermediate": 0,
          //             })));
          Get.offAllNamed("/dashboard", arguments: 0);
        } catch (e) {
          Get.back();
          ToastMessageCustom.ToastMessage(e.toString(), warningColor);
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      ToastMessageCustom.ToastMessage("${e.message}", primaryDarkColor,
          textColor: Colors.white);
    } catch (e) {
      Get.back();
      ToastMessageCustom.ToastMessage("$e", primaryDarkColor,
          textColor: Colors.white);
    }
  }

  void setValueFunction(String res) {
    if (indexRegist == 0) {
      genderRes = genderRes != res ? res : "";
    } else if (indexRegist == 1) {
      physicalRes = physicalRes != res ? res : "";
    } else if (indexRegist == 2) {
      goalRes = goalRes != res ? res : "";
    } else if (indexRegist == 3) {
      if (motivRes.isEmpty) {
        ToastMessageCustom.ToastMessage(
            "You Can Select More Than One", secondaryTextColor);
      }
      motivRes.contains(res) ? motivRes.remove(res) : motivRes.add(res);
    } else if (indexRegist == 4) {
      if (targetRes.isEmpty) {
        ToastMessageCustom.ToastMessage(
            "You Can Select More Than One", secondaryTextColor);
      }
      targetRes.contains(res) ? targetRes.remove(res) : targetRes.add(res);
    }
    continueRegistFunc();
  }

  @override
  void onInit() async {
    storageRef
        .child("DefaultProfilePicture.png")
        .getDownloadURL()
        .then((value) => urlPhoto = value.toString());
    super.onInit();
  }
}
