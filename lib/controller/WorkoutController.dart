import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../StorageProvider.dart';
import '../model/Challange.dart';
import '../model/WorkoutData.dart';
import '../widget/BasicLoader.dart';

class WorkoutController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase().ref();

  dynamic argumentData = Get.arguments;

  RxList<Challange> _challangeData = <Challange>[].obs;
  List<Challange> get challangeData => _challangeData.value;
  set challangeData(List<Challange> challangeData) => _challangeData.value = challangeData;

  Rx<int> _workoutIndex = 0.obs;
  int get workoutIndex => _workoutIndex.value;
  set workoutIndex(int workoutIndex) => _workoutIndex.value = workoutIndex;

  Rx<int> _challangeIndex = 0.obs;
  int get challangeIndex => _challangeIndex.value;
  set challangeIndex(int challangeIndex) => _challangeIndex.value = challangeIndex;

  Rx<String> _challengeSelected = "".obs;
  String get challengeSelected => _challengeSelected.value;
  set challengeSelected(String challengeSelected) => _challengeSelected.value = challengeSelected;

  RxList<int> _finishedChallange = <int>[].obs;
  List<int> get finishedChallange => _finishedChallange;
  set finishedChallange(List<int> finishedChallange) =>
      _finishedChallange.value = finishedChallange;

  Timer? timer;

  Rx<int> _restTime = 30.obs;
  int get restTime => _restTime.value;
  set restTime(int restTime) => _restTime.value = restTime;

  Rx<WorkoutData> _workoutData = WorkoutData().obs;
  WorkoutData get workoutData => _workoutData.value;
  set workoutData(WorkoutData workoutData) => _workoutData.value = workoutData;

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

  //Function to change finish challenge data
  Future finishWorkout() async {
    if (challengeSelected.contains("Beginner") || challengeSelected.contains("Intermediate")) {
      try {
        Get.dialog(BasicLoader());
        final userid = await StorageProvider.getUserToken();
        final data =
            await database.child("$userid").child("challengeData").child(challengeSelected).get();
        int finished = int.parse(data.value.toString()) + 1;
        await database
            .child("$userid")
            .child("challengeData")
            .child(challengeSelected)
            .set(finished);
        Get.offAllNamed("/dashboard", arguments: 1);
      } catch (e) {
        print(e);
      }
    } else {
      Get.offAllNamed("/dashboard", arguments: 0);
    }
  }

  //Function to get workout list data
  Future getWorkoutList(String workoutName) async {
    Get.dialog(BasicLoader());
    print(workoutName);
    try {
      final userid = await StorageProvider.getUserToken();
      final data = await database.child("WorkoutData").child(workoutName).get();
      print(data.key);
      workoutData = WorkoutData.fromJson(json.decode(json.encode(data.value)));
      final finished = await database.child("$userid").child("challengeData").get();
      if (workoutName.contains("Beginner") || workoutName.contains("Intermediate")) {
        int finished_ = int.parse(finished.child("$workoutName").value.toString());
        workoutData.reps = workoutData.reps! + finished_ * 2;
      }
      challengeSelected = workoutName;
      Get.back();
      Get.toNamed("/workoutlist");
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    finishedChallange = argumentData[0];
    workoutData = argumentData[1];
    challangeIndex = argumentData[2];
    challangeData = argumentData[3];
    super.onInit();
  }
}
