import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pain/feature/challenge/controller/WorkoutChallengeDetailController.dart';

import '../../../StorageProvider.dart';
import '../../../widget/BasicLoader.dart';
import '../../MainController.dart';
import '../../authentification/models/UserData.dart';
import '../../challenge/models/ChallengeModel.dart';

class WorkoutFinishController extends GetxController {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<String> _workoutName = "".obs;
  String get workoutName => _workoutName.value;
  set workoutName(String workoutName) => _workoutName.value = workoutName;

  String? idChallenge = Get.arguments?['challenge_id'];
  String? levelChallengeName = Get.arguments?['challenge_level_title'];

  Future finishWorkout() async {
    if (idChallenge == null) {
      Get.back();
      return;
    }

    try {
      Get.dialog(BasicLoader());
      final userid = await StorageProvider.getUserToken();
      final user_data =
          await firestore.collection("usersData").doc(userid).get();
      List<RecordChallengeDatum> recordChallenge =
          UserData.fromJson(user_data.data()!).recordChallengeData!;
      if (levelChallengeName == "Beginner") {
        recordChallenge
            .firstWhere((element) => element.id == idChallenge)
            .level!
            .beginner = recordChallenge
                .firstWhere((element) => element.id == idChallenge)
                .level!
                .beginner! +
            1;
      } else {
        recordChallenge
            .firstWhere((element) => element.id == idChallenge)
            .level!
            .intermediate = recordChallenge
                .firstWhere((element) => element.id == idChallenge)
                .level!
                .intermediate! +
            1;
      }
      await firestore.collection("usersData").doc(userid).update({
        'record_challenge_data':
            List<dynamic>.from(recordChallenge.map((x) => x.toJson())),
      });
      // await database
      //     .child("userDatabase")
      //     .child("$userid")
      //     .child("challengeData")
      //     .child(workoutName)
      //     .set(int.parse(challangeData!.total!) + 1);
      // c.currentIndex = 1;
      if (Get.isRegistered<WorkoutChallangeDetailController>()) {
        WorkoutChallangeDetailController c = Get.find();
        await c.getChallengeData();
      }

      Get.back();
      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onInit() {
    workoutName = Get.arguments['workout_name'];
    // TODO: implement onInit
    super.onInit();
  }
}
