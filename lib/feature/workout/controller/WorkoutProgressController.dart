import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pain/feature/MainController.dart';
import 'package:pain/feature/challenge/models/ChallengeModel.dart';

import '../../../StorageProvider.dart';
import '../models/WorkoutData.dart';
import '../../../widget/BasicLoader.dart';

class WorkoutProgressController extends GetxController {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<int> _workoutIndex = 0.obs;
  int get workoutIndex => _workoutIndex.value;
  set workoutIndex(int workoutIndex) => _workoutIndex.value = workoutIndex;

  Rx<WorkoutData> _workoutData = WorkoutData().obs;
  WorkoutData get workoutData => _workoutData.value;
  set workoutData(WorkoutData workoutData) => _workoutData.value = workoutData;

  Rx<String> _workoutName = "".obs;
  String get workoutName => _workoutName.value;
  set workoutName(String workoutName) => _workoutName.value = workoutName;


  Timer? timer;

  Rx<int> _restTime = 30.obs;
  int get restTime => _restTime.value;
  set restTime(int restTime) => _restTime.value = restTime;

  String? idChallenge = Get.arguments?['challenge_id'];
  String? levelChallengeName = Get.arguments?['challenge_level_title'];

  void runbacktime() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      restTime--;
      if (restTime == 0) {
        Get.back();
      }
    });
  }

  String formatTime() {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    Duration d = Duration(seconds: restTime);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }

  @override
  void onInit() {
    workoutData = Get.arguments['workout_data'];
    workoutName = Get.arguments['workout_name'];
    // TODO: implement onInit
    super.onInit();
  }
}
