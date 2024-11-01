import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pain/page/IntroPage/HomeScreen.dart';

import '../../../StorageProvider.dart';
import '../../../model/UserData.dart';
import '../../../widget/ToastMessageCustom.dart';

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
    try {
      final data = await firestore.collection("usersData").doc(userid).get();
      user = UserData.fromJson(json.decode(json.encode(data.data())));
      goalTemp = user.goal!;
      physicTemp = user.physical!;
      muscleTemp.clear();
      muscle.clear();
      for (int i = 0; i < user.targetMuscle!.length; i++) {
        muscleTemp.add(user.targetMuscle![i].muscle!);
        muscle.add(user.targetMuscle![i].muscle!);
      }
      muscle.sort();
      muscleTemp.sort();
    } catch (e) {
      Get.offAll(HomeScreen());
    }
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
  }

  @override
  void onInit() async {
    userid = await StorageProvider.getUserToken();
    if (userid == null) {
      Get.to(() => HomeScreen());
    }
    loading = true;
    await getUserData();
    loading = false;
    super.onInit();
  }
}
