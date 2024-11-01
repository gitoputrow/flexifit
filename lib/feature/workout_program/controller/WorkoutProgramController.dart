import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pain/StorageProvider.dart';

import '../../../model/ProgramWO.dart';
import '../../../model/UserData.dart';
import '../../../model/WorkoutData.dart';
import '../../../page/IntroPage/HomeScreen.dart';
import '../../../widget/BasicLoader.dart';

class WorkoutProgramController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<UserData> _user = UserData().obs;
  UserData get user => _user.value;
  set user(UserData user) => _user.value = user;

  Rx<String> _dayTitle = "".obs;
  String get dayTitle => _dayTitle.value;
  set dayTitle(String dayTitle) => _dayTitle.value = dayTitle;

  RxList<ProgramWO> _programWO = <ProgramWO>[].obs;
  List<ProgramWO> get programWO => _programWO.value;
  set programWO(List<ProgramWO> programWO) => _programWO.value = programWO;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  RxList<String> _muscle = <String>[].obs;
  List<String> get muscle => _muscle.value;
  set muscle(List<String> muscle) => _muscle.value = muscle;

  Rx<WorkoutData> _workoutData = WorkoutData().obs;
  WorkoutData get workoutData => _workoutData.value;
  set workoutData(WorkoutData workoutData) => _workoutData.value = workoutData;

  Rx<String> _challengeSelected = "".obs;
  String get challengeSelected => _challengeSelected.value;
  set challengeSelected(String challengeSelected) =>
      _challengeSelected.value = challengeSelected;

  List<String> sortedDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  String userid = "";

  Future getUserData() async {
    try {
      final data = await firestore.collection("usersData").doc(userid).get();
      user = UserData.fromJson(json.decode(json.encode(data.data())));
      muscle = List.from(user.targetMuscle!.map((e) => e.muscle));
    } catch (e) {
      Get.offAll(HomeScreen());
    }
  }

  // Future getWorkoutList(String workoutName) async {
  //   Get.dialog(BasicLoader());
  //   try {
  //     final data = await database.child("WorkoutData").child(workoutName).get();
  //     workoutData = WorkoutData.fromJson(json.decode(json.encode(data.value)));
  //     final finished = await database
  //         .child("userDatabase")
  //         .child("$userid")
  //         .child("challengeData")
  //         .get();
  //     if (workoutName.contains("Beginner") ||
  //         workoutName.contains("Intermediate")) {
  //       int finished_ =
  //           int.parse(finished.child("$workoutName").value.toString());
  //       workoutData.reps = workoutData.reps! + finished_ * 2;
  //     }
  //     challengeSelected = workoutName;
  //     Get.back();
  //     Get.toNamed("/workoutlist", arguments: [
  //       finishedChallange,
  //       workoutData,
  //       challangeIndex,
  //       challangeData
  //     ]);
  //   } catch (e) {}
  // }

  Future getProgramData() async {
    try {
      int indexMuscle = 0;
      programWO.clear();
      final data = await database
          .child("ProgramWO")
          .child(user.physical!)
          .child(user.goal!)
          .get();
      programWO = List.from(data.children
          .map((e) => ProgramWO.fromJson(json.decode(json.encode(e.value)))));
      programWO.sort((a, b) =>
          sortedDays.indexOf(a.day!).compareTo(sortedDays.indexOf(b.day!)));
      for (var i = 0; i < programWO.length; i++) {
        if (!programWO[i].title!.contains("Cardio") &&
            !programWO[i].title!.contains("Full Body")) {
          await getMuscleSplit(programWO, i, muscle, indexMuscle)
              .then((value) => indexMuscle = indexMuscle + 1);
        }
        await database
            .child('WorkoutData')
            .child(programWO[i].workoutName!)
            .get()
            .then((value) => programWO[i].workoutData =
                WorkoutData.fromJson(json.decode(json.encode(value.value))));
      }
      if (data.child(DateFormat('EEEE', 'en').format(DateTime.now())).exists) {
        dayTitle = programWO[programWO.indexWhere((element) => element.day!
                .contains(DateFormat('EEEE', 'en').format(DateTime.now())))]
            .dayDesc!;
      } else {
        dayTitle = "Today is Rest day";
      }
    } catch (e) {
      log("error ${e.toString()}");
    }
  }

  Future getMuscleSplit(
      List<ProgramWO> programWO, int i, List muscle, int iMuscle) async {
    String splitMuscleDesc = programWO[i].title!;
    String splitMuscleDay = programWO[i].dayDesc!;
    String splitMuscleName = programWO[i].workoutName!;
    String splitMuscleImg = "";
    if (user.physical == "new" || user.physical == "pro") {
      splitMuscleDesc = splitMuscleDesc.replaceAll(
          "name_",
          muscle.length == 1
              ? muscle[0]
              : muscle.length == 2
                  ? muscle[iMuscle]
                  : muscle.length == 4
                      ? "${muscle[iMuscle + iMuscle]} And ${muscle[iMuscle + iMuscle + 1]}"
                      : muscle.length == 3
                          ? iMuscle == 1
                              ? muscle[2]
                              : "${muscle[0]} And ${muscle[1]}"
                          : "a");
      splitMuscleDay = splitMuscleDay.replaceAll(
          "name_",
          muscle.length == 1
              ? muscle[0]
              : muscle.length == 2
                  ? muscle[iMuscle]
                  : muscle.length == 4
                      ? "${muscle[iMuscle + iMuscle]} And ${muscle[iMuscle + iMuscle + 1]}"
                      : muscle.length == 3
                          ? iMuscle == 1
                              ? muscle[2]
                              : "${muscle[0]} And ${muscle[1]}"
                          : "a");
      splitMuscleName = splitMuscleName.replaceAll(
          "name_",
          muscle.length == 1
              ? muscle[0]
              : muscle.length == 2
                  ? muscle[iMuscle]
                  : muscle.length == 4
                      ? "${muscle[iMuscle + iMuscle]}and${muscle[iMuscle + iMuscle + 1]}"
                      : muscle.length == 3
                          ? iMuscle == 1
                              ? muscle[2]
                              : "${muscle[0]}and${muscle[1]}"
                          : "a");
      splitMuscleImg = muscle.length == 1
          ? "${muscle[0]}Pic.png"
          : muscle.length == 2
              ? "${muscle[iMuscle]}Pic.png"
              : muscle.length == 4
                  ? "${muscle[iMuscle + iMuscle]}and${muscle[iMuscle + iMuscle + 1]}Pic.png"
                  : muscle.length == 3
                      ? iMuscle == 1
                          ? "${muscle[2]}Pic.png"
                          : "${muscle[0]}and${muscle[1]}Pic.png"
                      : "a";
    } else if (user.physical == "master") {
      splitMuscleDesc = splitMuscleDesc.replaceAll(
          "name_",
          muscle.length == 1
              ? muscle[0]
              : muscle.length == 3
                  ? muscle[iMuscle]
                  : muscle.length == 2
                      ? iMuscle == 2
                          ? "${muscle[iMuscle - 2]} And ${muscle[iMuscle - 1]}"
                          : muscle[iMuscle]
                      : muscle.length == 4
                          ? iMuscle != 2
                              ? "${muscle[iMuscle]}"
                              : "${muscle[iMuscle]} And ${muscle[iMuscle + 1]}"
                          : "a");

      splitMuscleDay = splitMuscleDay.replaceAll(
          "name_",
          muscle.length == 1
              ? muscle[0]
              : muscle.length == 3
                  ? muscle[iMuscle]
                  : muscle.length == 2
                      ? iMuscle == 2
                          ? "${muscle[iMuscle - 2]} And ${muscle[iMuscle - 1]}"
                          : muscle[iMuscle]
                      : muscle.length == 4
                          ? iMuscle != 2
                              ? "${muscle[iMuscle]}"
                              : "${muscle[iMuscle]} And ${muscle[iMuscle + 1]}"
                          : "a");
      splitMuscleName = splitMuscleName.replaceAll(
          "name_",
          muscle.length == 1
              ? muscle[0]
              : muscle.length == 3
                  ? muscle[iMuscle]
                  : muscle.length == 2
                      ? iMuscle == 2
                          ? "${muscle[iMuscle - 2]}and${muscle[iMuscle - 1]}"
                          : muscle[iMuscle]
                      : muscle.length == 4
                          ? iMuscle != 2
                              ? "${muscle[iMuscle]}"
                              : "${muscle[iMuscle]}and${muscle[iMuscle + 1]}"
                          : "a");
      splitMuscleImg = muscle.length == 1
          ? muscle[0]
          : muscle.length == 3
              ? "${muscle[iMuscle]}Pic.png"
              : muscle.length == 2
                  ? iMuscle == 2
                      ? "${muscle[iMuscle - 2]}and${muscle[iMuscle - 1]}Pic.png"
                      : "${muscle[iMuscle]}Pic.png"
                  : muscle.length == 4
                      ? iMuscle != 2
                          ? "${muscle[iMuscle]}Pic.png"
                          : "${muscle[iMuscle]}and${muscle[iMuscle + 1]}Pic.png"
                      : "a";
    }
    programWO[i].dayDesc = splitMuscleDay;
    programWO[i].title = splitMuscleDesc;
    programWO[i].workoutName = splitMuscleName;
    await storageRef
        .child("Program_Image")
        .child(splitMuscleImg)
        .getDownloadURL()
        .then((value) => programWO[i].picture = value.toString());
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    loading = true;
    userid = (await StorageProvider.getUserToken())!;
    await getUserData();
    await getProgramData();
    loading = false;
    super.onInit();
  }
}
