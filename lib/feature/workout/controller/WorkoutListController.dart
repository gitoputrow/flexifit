import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/models/UserData.dart';
import 'package:pain/feature/challenge/models/ChallengeModel.dart';

import '../../../StorageProvider.dart';
import '../models/WorkoutData.dart';

class WorkoutListController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<WorkoutData> _workoutData = WorkoutData().obs;
  WorkoutData get workoutData => _workoutData.value;
  set workoutData(WorkoutData workoutData) => _workoutData.value = workoutData;

  Rx<String> _workoutName = "".obs;
  String get workoutName => _workoutName.value;
  set workoutName(String workoutName) => _workoutName.value = workoutName;

  String? idChallenge = Get.arguments?['challenge_id'];
  String? levelChallengeName = Get.arguments?['challenge_level_title'];

  Future getWorkoutList() async {
    loading = true;
    try {
      final userid = await StorageProvider.getUserToken();
      final data = await database.child("WorkoutData").child(workoutName).get();
      workoutData = WorkoutData.fromJson(json.decode(json.encode(data.value)));
      final user_data =
          await firestore.collection("usersData").doc(userid).get();
      UserData userData = UserData.fromJson(user_data.data()!);
      if (idChallenge != null || levelChallengeName != null) {
        int finished_ = () {
          RecordChallengeDatum data = userData.recordChallengeData!
              .firstWhere((element) => element.id == idChallenge);
          if (levelChallengeName == "Beginner") {
            return data.level!.beginner!;
          } else {
            return data.level!.intermediate!;
          }
        }();
        workoutData.reps = workoutData.reps! + finished_ * 2;
      }

      log(workoutData.reps.toString());
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  @override
  void onInit() async {
    workoutData = Get.arguments['workout_data'];
    workoutName = Get.arguments['workout_name'];
    await getWorkoutList();
    // TODO: implement onInit
    super.onInit();
  }
}
