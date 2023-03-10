import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pain/Page/registerpage/registPageStep/RegistPageStep2.dart';
import 'package:pain/Page/registerpage/registPageStep/RegistPageStep3.dart';
import 'package:pain/Page/registerpage/registPageStep/RegistPageStep5.dart';
import 'package:pain/StorageProvider.dart';
import 'package:pain/model/UserData.dart';
import 'package:pain/model/WorkoutData.dart';
import 'package:pain/widget/ToastMessageCustom.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../Page/registerpage/registPageStep/RegistPageStep1.dart';
import '../Page/registerpage/registPageStep/RegistPageStep4.dart';
import '../Page/registerpage/registPageStep/RegistPageStep6.dart';
import '../Page/registerpage/registPageStep/RegistPageStep7.dart';
import '../widget/BasicLoader.dart';

class AuthentificationController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseReference database = FirebaseDatabase().ref();

  Rx<bool> _passVisble = false.obs;
  bool get passVisble => _passVisble.value;
  set passVisble(bool passVisble) => _passVisble.value = passVisble;

  Rx<bool> _passResistVisble = false.obs;
  bool get passResistVisble => _passResistVisble.value;
  set passResistVisble(bool passResistVisble) => _passResistVisble.value = passResistVisble;

  Rx<bool> _cpassResistVisble = false.obs;
  bool get cpassResistVisble => _cpassResistVisble.value;
  set cpassResistVisble(bool cpassResistVisble) => _cpassResistVisble.value = cpassResistVisble;

  RxString hint = "Insert Your Password".obs;

  Rx<int> _indexRegist = 0.obs;
  int get indexRegist => _indexRegist.value;
  set indexRegist(int indexRegist) => _indexRegist.value = indexRegist;

  Rx<String> _genderRes = "".obs;
  String get genderRes => _genderRes.value;
  set genderRes(String genderRes) => _genderRes.value = genderRes;

  Rx<String> _goalRes = "".obs;
  String get goalRes => _goalRes.value;
  set goalRes(String goalRes) => _goalRes.value = goalRes;

  Rx<bool> _continuePermission = false.obs;
  bool get continuePermission => _continuePermission.value;
  set continuePermission(bool continuePermission) => _continuePermission.value = continuePermission;

  Rx<bool> _usernameExist = false.obs;
  bool get usernameExist => _usernameExist.value;
  set usernameExist(bool usernameExist) => _usernameExist.value = usernameExist;

  Rx<bool> _passCheck = false.obs;
  bool get passCheck => _passCheck.value;
  set passCheck(bool passCheck) => _passCheck.value = passCheck;

  Rx<String> _idToken = "".obs;
  String get idToken => _idToken.value;
  set idToken(String idToken) => _idToken.value = idToken;

  Rx<String> _physicalRes = "".obs;
  String get physicalRes => _physicalRes.value;
  set physicalRes(String physicalRes) => _physicalRes.value = physicalRes;

  RxList<String> _motivRes = <String>[].obs;
  List<String> get motivRes => _motivRes;
  set motivRes(List<String> motivRes) => _motivRes.value = motivRes;

  RxList<String> _targetRes = <String>[].obs;
  List<String> get targetRes => _targetRes;
  set targetRes(List<String> targetRes) => _targetRes.value = targetRes;

  var inputName = TextEditingController();
  String urlPhoto = "";

  final storageRef = FirebaseStorage.instance.ref();

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

  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> age = TextEditingController().obs;
  Rx<TextEditingController> weight = TextEditingController().obs;
  Rx<TextEditingController> height = TextEditingController().obs;
  Rx<TextEditingController> username = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> cpassword = TextEditingController().obs;

  Rx<TextEditingController> usernameLogin = TextEditingController().obs;
  Rx<TextEditingController> passwordLogin = TextEditingController().obs;

  List<String> RegistButTitle = ["Continue", "Finish", "Let's Get Fit"];

  List<Widget> StepPage = [
    RegistPageStep1(),
    RegistPageStep2(),
    RegistPageStep3(),
    RegistPageStep4(),
    RegistPageStep5(),
    RegistPageStep6(),
    RegistPageStep7()
  ];

  DropButFunction(int page, String res) {
    if (page == 1) {
      if (genderRes != res) {
        genderRes = res;
        continuePermission = true;
      } else {
        genderRes = "";
        continuePermission = false;
      }
    } else if (page == 2) {
      if (physicalRes != res) {
        physicalRes = res;
        continuePermission = true;
      } else {
        physicalRes = "";
        continuePermission = false;
      }
    } else if (page == 3) {
      if (goalRes != res) {
        goalRes = res;
        continuePermission = true;
      } else {
        goalRes = "";
        continuePermission = false;
      }
    } else if (page == 4) {
      if (motivRes.isEmpty) {
        ToastMessageCustom.ToastMessage(
            "You Can Select More Than One", Color.fromRGBO(10, 12, 13, 0.8));
      }
      if (motivRes.contains(res)) {
        motivRes.remove(res);
        if (motivRes.isEmpty) {
          continuePermission = false;
        }
      } else {
        motivRes.add(res);
        continuePermission = true;
      }
    } else if (page == 5) {
      if (targetRes.isEmpty) {
        ToastMessageCustom.ToastMessage(
            "You Can Select More Than One", Color.fromRGBO(10, 12, 13, 0.8));
      }
      if (targetRes.contains(res)) {
        targetRes.remove(res);
        if (targetRes.isEmpty) {
          continuePermission = false;
        }
      } else {
        targetRes.add(res);
        continuePermission = true;
      }
    }
  }

  bool continueCondition(int index, bool condition) {
    if (condition && indexRegist == index) {
      return continuePermission = false;
    } else {
      return continuePermission = true;
    }
  }

  Future checkUsernameandPass(String username, password) async {
    final data = await database.get();
    for (var children in data.children) {
      if (username == children.child("username").value.toString()) {
        usernameExist = true;
        if (password == children.child("pass").value.toString()) {
          passCheck = true;
          idToken = children.key.toString();
        }
        break;
      }
    }
  }

  Future checkUsername(String username) async {
    final data = await database.get();
    for (var children in data.children) {
      if (username == children.child("username").value.toString()) {
        usernameExist = true;
        break;
      }
    }
  }

  Future login() async {
    if (usernameLogin.value.text.isEmpty || passwordLogin.value.text.isEmpty) {
      ToastMessageCustom.ToastMessage(
          "Fill Username or Password", Color.fromARGB(204, 245, 60, 13));
    } else {
      Get.dialog(BasicLoader());
      await checkUsernameandPass(usernameLogin.value.text, passwordLogin.value.text);
      if (usernameExist == true) {
        if (passCheck == true) {
          await StorageProvider.setUserToken(idToken);
          Get.offAllNamed("/dashboard");
        } else {
          Get.back();
          ToastMessageCustom.ToastMessage("Wrong Password", Color.fromARGB(204, 245, 60, 13));
        }
      } else {
        Get.back();
        ToastMessageCustom.ToastMessage("Username Not Found", Color.fromARGB(204, 245, 60, 13));
      }
      // final collectExist = await firestore.collection("data${usernameLogin.value.text}").get();
      // if (collectExist.size == 0) {
      //   Get.back();
      //   ToastMessageCustom.ToastMessage("Username Not Found", Color.fromARGB(204, 245, 60, 13));
      // } else {
      //   await firestore
      //       .collection("data${usernameLogin.value.text}")
      //       .doc("data")
      //       .get()
      //       .then((value) {
      //     String pass = value.data()!['pass'];
      //     if (pass == passwordLogin.value.text) {
      //       Get.offAllNamed("/dashboard");
      //     } else {
      //       Get.back();
      //       ToastMessageCustom.ToastMessage("Wrong Password", Color.fromARGB(204, 245, 60, 13));
      //     }
      //   });
      // }
    }
  }

  List<String> daySplit = [];
  List<String> workoutSplit = [];
  void setProgram() {
    if (goalRes == "burn") {
      if (physicalRes == "new" || physicalRes == "newb") {
        daySplit = ["Monday", "Wednesday", "Friday"];
      }
    }
  }

  Future regist() async {
    Get.dialog(BasicLoader());
    List<Map<String, dynamic>> muscledata = [];
    if (physicalRes == "newb") {
      physicalRes = "new";
    }
    targetRes.sort();
    for (var i = 0; i < targetRes.length; i++) {
      muscledata.add({"muscle": targetRes[i]});
    }
    // muscledata.a
    List<Map<String, dynamic>> challange = [
      {"value": 0, "title": "Full Body"},
      {"value": 0, "title": "Abs"},
      {"value": 0, "title": "Arms"},
      {"value": 0, "title": "Legs"},
      {"value": 0, "title": "Chest"},
      {"value": 0, "title": "Cardio"},
      {"value": 0, "title": "Legs"},
      {"value": 0, "title": "Biceps"},
      {"value": 0, "title": "Triceps"}
    ];

    Map<String, dynamic> dataUser = {
      "gender": genderRes,
      "goal": goalRes,
      "physical": physicalRes,
      "name": name.value.text,
      "age": age.value.text,
      "weight": weight.value.text,
      "height": height.value.text,
      "pass": password.value.text,
      "username": username.value.text,
      "photoprofile": urlPhoto
    };
    await checkUsername(username.value.text);
    if (usernameExist == true) {
      Get.back();
      ToastMessageCustom.ToastMessage("Username already taken", Color.fromARGB(204, 245, 60, 13));
    } else {
      String id = database.push().key.toString();
      try {
        await database.child("$id").set(dataUser).whenComplete(() => database
            .child("$id")
            .child("targetMuscle")
            .set(muscledata)
            .whenComplete(() => database.child("$id").child("challengeData").set({
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
                })));
        await StorageProvider.setUserToken(id);
        Get.offAllNamed("/dashboard");
      } catch (e) {
        Get.back();
        ToastMessageCustom.ToastMessage(e.toString(), Color.fromARGB(204, 245, 60, 13));
      }
    }
    // final collectExist = await firestore.collection("data${username.value.text}").get();
    // if (collectExist.size != 0) {
    //   Get.back();
    //   ToastMessageCustom.ToastMessage("Username already taken", Color.fromARGB(204, 245, 60, 13));
    // } else {
    //   try {
    //     await firestore
    //         .collection("data${username.value.text}")
    //         .doc("data")
    //         .set(dataUser)
    //         .whenComplete(() => firestore
    //             .collection("data${username.value.text}")
    //             .doc("targetMuscle")
    //             .set(muscledata)
    //             .whenComplete(
    //                 () => firestore.collection("data${username.value.text}").doc("challange").set({
    //                       "FullBodyBeginner": 0,
    //                       "AbsBeginner": 0,
    //                       "TricepsBeginner": 0,
    //                       "BicepsBeginner": 0,
    //                       "ChestBeginner": 0,
    //                       "LegsBeginner": 0,
    //                       "CardioBeginner": 0,
    //                       "FullBodyIntermediate": 0,
    //                       "AbsIntermediate": 0,
    //                       "TricepsIntermediate": 0,
    //                       "BicepsIntermediate": 0,
    //                       "ChestIntermediate": 0,
    //                       "LegsIntermediate": 0,
    //                       "CardioIntermediate": 0,
    //                     })));
    //     Get.offAllNamed("/dashboard");
    //   } catch (e) {
    //     Get.back();
    //     ToastMessageCustom.ToastMessage(e.toString(), Color.fromARGB(204, 245, 60, 13));
    //   }
    // }
  }

  continueRegistFunc() {
    if (indexRegist == 0) {
      continueCondition(0, genderRes == "");
    } else if (indexRegist == 1) {
      continueCondition(1, physicalRes == "");
    } else if (indexRegist == 2) {
      continueCondition(2, goalRes == "");
    } else if (indexRegist == 3) {
      continueCondition(3, motivRes.isEmpty);
    } else if (indexRegist == 4) {
      continueCondition(4, targetRes.isEmpty);
    } else if (indexRegist == 5) {
      continueCondition(
          5,
          name.value.text == "" ||
              age.value.text == "" ||
              weight.value.text == "" ||
              height.value.text == "");
    } else if (indexRegist == 6) {
      continueCondition(
          6, username.value.text == "" || password.value.text == "" || cpassword.value.text == "");
    }
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
