import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pain/model/Challange.dart';

import '../../../StorageProvider.dart';
import '../../../model/WorkoutData.dart';
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

  Rx<Level?> _challangeData = (null as Level?).obs;
  Level? get challangeData => _challangeData.value;
  set challangeData(Level? challangeData) =>
      _challangeData.value = challangeData;

  Timer? timer;

  Rx<int> _restTime = 30.obs;
  int get restTime => _restTime.value;
  set restTime(int restTime) => _restTime.value = restTime;

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

  Future finishWorkout() async {
    if (challangeData != null) {
      try {
        Get.dialog(BasicLoader());
        final userid = await StorageProvider.getUserToken();
        await firestore.collection("usersData").doc(userid).update({
          "challenge_data.$workoutName": int.parse(challangeData!.total!) + 1
        });
        // await database
        //     .child("userDatabase")
        //     .child("$userid")
        //     .child("challengeData")
        //     .child(workoutName)
        //     .set(int.parse(challangeData!.total!) + 1);
        Get.offAllNamed("/dashboard", arguments: 1);
      } catch (e) {
        print(e);
      }
    } else {
      Get.offAllNamed("/dashboard", arguments: 0);
    }
  }

  @override
  void onInit() {
    workoutData = Get.arguments['workout_data'];
    workoutName = Get.arguments['workout_name'];
    challangeData = Get.arguments?['challenge_data'];
    print(challangeData);
    // TODO: implement onInit
    super.onInit();
  }
}
