import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../StorageProvider.dart';
import '../../../model/WorkoutData.dart';

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

  Future getWorkoutList() async {
    loading = true;
    try {
      final userid = await StorageProvider.getUserToken();
      final data = await database.child("WorkoutData").child(workoutName).get();
      workoutData = WorkoutData.fromJson(json.decode(json.encode(data.value)));
      final finished =
          await firestore.collection("usersData").doc(userid).get();
      if (workoutName.contains("Beginner") ||
          workoutName.contains("Intermediate")) {
        int finished_ =
            int.parse(finished.data()!["challenge_data"]["$workoutName"].toString());
        workoutData.reps = workoutData.reps! + finished_ * 2;
      }
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  @override
  void onInit() {
    workoutData = Get.arguments['workout_data'];
    workoutName = Get.arguments['workout_name'];
    // TODO: implement onInit
    super.onInit();
  }
}
