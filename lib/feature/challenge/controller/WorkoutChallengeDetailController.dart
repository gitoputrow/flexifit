import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pain/StorageProvider.dart';
import 'package:pain/feature/authentification/models/UserData.dart';
import 'package:pain/feature/challenge/models/ChallengeModel.dart';
import 'package:pain/feature/workout/models/WorkoutData.dart';

class WorkoutChallangeDetailController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<ChallengeModel> _challangeData = ChallengeModel().obs;
  ChallengeModel get challangeData => _challangeData.value;
  set challangeData(ChallengeModel challangeData) =>
      _challangeData.value = challangeData;

  String title = Get.arguments['title'];
  String id = Get.arguments['id'];

  Future getChallengeData() async {
    loading = true;
    try {
      final data = await firestore.collection("challengeData").doc(id).get();
      challangeData = ChallengeModel.fromJson(data.data()!);
      final token = await StorageProvider.getUserToken();
      final data_user =
          await firestore.collection("usersData").doc(token).get();
      UserData user = UserData.fromJson(data_user.data()!);
      challangeData.level!.firstWhere((element) {
        return element.title == "Beginner";
      }).total = user.recordChallengeData!
          .firstWhere((element) {
            return element.id == id;
          })
          .level!
          .beginner
          .toString();
      challangeData.level!.firstWhere((element) {
        return element.title == "Intermediate";
      }).total = user.recordChallengeData!
          .firstWhere((element) {
            return element.id == id;
          })
          .level!
          .intermediate
          .toString();
      for (int i = 0; i < challangeData.level!.length; i++) {
        await database
            .child("WorkoutData")
            .child("${challangeData.title}${challangeData.level![i].title}")
            .get()
            .then((value) => challangeData.level![i].workoutData =
                WorkoutData.fromJson(json.decode(json.encode(value.value))));
      }
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  @override
  void onReady() async {
    // TODO: implement onReady

    await getChallengeData();
    super.onReady();
  }
}
