import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pain/StorageProvider.dart';
import 'package:pain/model/Challange.dart';
import 'package:pain/model/WorkoutData.dart';

class WorkoutChallangeDetailController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<Challange> _challangeData = Challange().obs;
  Challange get challangeData => _challangeData.value;
  set challangeData(Challange challangeData) =>
      _challangeData.value = challangeData;

  Future getChallengeData() async {
    try {
      final data = await database
          .child("ChallengeWO")
          .child(Get.arguments['title'])
          .get();
      challangeData = Challange.fromJson(json.decode(json.encode(data.value)));
      final token = await StorageProvider.getUserToken();
      for (int i = 0; i < challangeData.level!.length; i++) {
        // await database
        //     .child("userDatabase")
        //     .child(token!)
        //     .child("challengeData")
        //     .child("${challangeData.title}${challangeData.level![i].title}")
        //     .get()
        //     .then((value) =>
        //         challangeData.level![i].total = value.value.toString());

        await firestore.collection("usersData").doc(token).get().then((value) {
          challangeData.level![i].total = value.data()!["challenge_data"]
              ["${challangeData.title}${challangeData.level![i].title}"].toString();
        });

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
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    loading = true;
    await getChallengeData();
    loading = false;
    super.onReady();
  }
}
