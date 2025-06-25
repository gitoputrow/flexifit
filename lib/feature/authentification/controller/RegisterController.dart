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

  double? dailyProtein = 0.0;
  double? dailyCalories = 0.0;

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

  void setProteinDaily() {
    double proteinPerGram = () {
      if (physicalRes == "new") {
        return goalRes == "build" ? 1.4 : 1.6;
      }
      if (physicalRes == "newb") {
        return goalRes == "build" ? 1.6 : 1.8;
      }
      if (physicalRes == "pro") {
        return goalRes == "build" ? 1.8 : 2.0;
      }
      if (physicalRes == "master") {
        return goalRes == "build" ? 2.0 : 2.4;
      }
      return 0.0;
    }();
    dailyProtein = double.parse(payload['weight'] ?? "0.0") * proteinPerGram;
  }

  void setCaloriesDaily() {
    double activityFactor = () {
      if (physicalRes == "new") {
        return 1.2;
      }
      if (physicalRes == "newb") {
        return 1.375;
      }
      if (physicalRes == "pro") {
        return 1.55;
      }
      if (physicalRes == "master") {
        return 1.725;
      }
      return 0.0;
    }();

    double bmrMinusValue = genderRes == "male" ? 5 : 161;

    double height = double.parse(payload['height'] ?? "0.0");
    double weight = double.parse(payload['weight'] ?? "0.0");
    double age = double.parse(payload['age'] ?? "0.0");

    double bmr = (10 * weight) + (6.25 * height) + (5 * age) - bmrMinusValue;

    dailyCalories = () {
      if (goalRes == "build") {
        return bmr * activityFactor + 250;
      } else {
        return bmr * activityFactor - 250;
      }
    }();
  }

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

  List<String> generateUsernameSearchKeywords(String text) {
    text = text.toLowerCase().trim();
    final substrings = <String>{};

    for (int i = 0; i < text.length; i++) {
      for (int j = i + 1; j <= text.length; j++) {
        substrings.add(text.substring(i, j));
      }
    }

    return substrings.toList();
  }

  Future regist() async {
    Get.dialog(BasicLoader());

    setCaloriesDaily();
    setProteinDaily();

    payload.removeWhere((key, value) => key == "pass_confirm");
    payload.removeWhere((key, value) => key == "pass");

    payload.addAll(
        {"keywords": generateUsernameSearchKeywords(username.value.text)});

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
      "comment": 0,
      "post": 0,
      "photo_profile": urlPhoto,
      "record_challenge_data": [
        {
          "title": "Abs",
          "id": "PfbXihMQv8vzBPjfhSVs",
          "level": {"beginner": 0, "intermediate": 0},
          "url": ""
        },
        {
          "title": "Leg's",
          "id": "LqFKTAaXpkelKBseL6lT",
          "level": {"beginner": 0, "intermediate": 0},
          "url": ""
        },
        {
          "title": "Chest",
          "id": "T276gfLLARFuh8iFVsjw",
          "level": {"beginner": 0, "intermediate": 0},
          "url": ""
        },
        {
          "title": "Cardio",
          "id": "ZomyRPsip3IHCrZhLNlH",
          "level": {"beginner": 0, "intermediate": 0},
          "url": ""
        },
        {
          "title": "Tricep's",
          "id": "bv6YQXSYsWtr7ilThbBe",
          "level": {"beginner": 0, "intermediate": 0},
          "url": ""
        },
        {
          "title": "Bicep's",
          "id": "jnzxFst3yI2bCZQGsf6E",
          "level": {"beginner": 0, "intermediate": 0},
          "url": ""
        },
        {
          "title": "Full body",
          "id": "nwKA0wdPYHS2fTaSfFxJ",
          "level": {"beginner": 0, "intermediate": 0},
          "url": ""
        },
      ],
    };

    Map<String, dynamic> bodyInformation = {};

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
          await firestore
              .collection('usersData')
              .add(dataUser)
              .then((value) async {
            await firestore
                .collection("usersData")
                .doc(value.id)
                .update({"id": value.id});
            await firestore
                .collection("bodyInformationData")
                .doc(value.id)
                .set({
              "idUser": value.id,
              "information": [
                {
                  "title": "Your Goal",
                  "value":
                      goalRes == "build" ? "Build More Muscle" : "Lose Weight",
                  "sort": 1
                },
                {
                  "title": "Daily Protein",
                  "value": "${dailyProtein?.toStringAsFixed(2)} Gram",
                  "info": {
                    "title": "Where did we get this value?",
                    "body":
                        "Protein Per Gram\nBuild Muscle : 1.4 - 2.0 gram/kg Body Weight\nBurn Fat : 1.6 - 2.4 gram/kg Body Weight",
                    "formula": "Body Weight (Kg) X Protein Per Gram",
                    "source": [
                      {
                        "title": "Protein For Build Muscle",
                        "value":
                            "https://jissn.biomedcentral.com/articles/10.1186/s12970-017-0177-8"
                      },
                      {
                        "title": "Protein For Burn Fat",
                        "value":
                            "https://faseb.onlinelibrary.wiley.com/doi/epdf/10.1096/fj.13-230227"
                      }
                    ]
                  },
                  "sort": 2
                },
                {
                  "title": "Daily Calories",
                  "value": "${dailyCalories?.toStringAsFixed(2)} Kcal",
                  "info": {
                    "title": "Where did we get this value?",
                    "body": """
  Activity Multiplier : 1.2 - 1.725\n
  Calories Adjustment
  +250 For Building Muscle
  -250 For Burn Fat""",
                    "formula": """BMR For Man 
  (10×weight (kg))+(6.25×height (cm))−(5×age (years))+5\n
  BMR For Woman
  (10×weight (kg))+(6.25×height (cm))−(5×age (years))-161\n
 (BMR x Activity Multiplier) +/- Calories Adjustment""",
                    "source": [
                      {
                        "title": "BMR Mifflin-St Jeor Equation",
                        "value":
                            "https://healthhappinesslongevity.com/ANewPredictiveEquationForRestingEnergyExpenditureInHealthyIndividuals.pdf"
                      },
                    ]
                  },
                  "sort": 2
                }
              ]
            });
            await StorageProvider.setUserToken(value.id);
          });

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
