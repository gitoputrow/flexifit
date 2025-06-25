import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pain/feature/places/models/WorkoutPlacesModel.dart';

import '../../../StorageProvider.dart';
import '../models/ReportPlaceModel.dart';

class PlacesDetailController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<WorkoutPlacesModel> _calisthenicsPark = WorkoutPlacesModel().obs;
  WorkoutPlacesModel get calisthenicsPark => _calisthenicsPark.value;
  set calisthenicsPark(WorkoutPlacesModel calisthenicsPark) =>
      _calisthenicsPark.value = calisthenicsPark;

  RxList<ReportPlaceModel> _reportPlaceData = <ReportPlaceModel>[].obs;
  List<ReportPlaceModel> get reportPlaceData => _reportPlaceData.value;
  set reportPlaceData(List<ReportPlaceModel> reportPlaceData) =>
      _reportPlaceData.value = reportPlaceData;

  String id = Get.arguments['id'];

  String? userid = "";

  Future<void> getData() async {
    loading = true;
    await Future.wait([getReportData(), getCalisthenicsParkData()]);
    loading = false;
  }

  Future<void> getReportData() async {
    try {
      final data = await firestore
          .collection("reportsData")
          .where('place_id', isEqualTo: id)
          .limit(4)
          .get();

      reportPlaceData =
          List.from(data.docs.map((e) => ReportPlaceModel.fromJson(e.data())));

      for (var element in reportPlaceData) {
        await firestore.collection("usersData").doc(element.userId).get().then(
          (value) {
            element.canDelete = element.userId == userid;
            element.profilepicture = value.data()?['photo_profile'];
            element.username = () {
              if (element.userId == userid) {
                return "You";
              } else {
                return value.data()?['username'];
              }
            }();
            element.userNickName = value.data()?['name'];
          },
        );
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  Future<void> getCalisthenicsParkData() async {
    try {
      // Step 1: Get the user's current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double userLat = position.latitude;
      double userLng = position.longitude;

      final data = await firestore.collection("placesData").doc(id).get();

      calisthenicsPark = WorkoutPlacesModel.fromJson(data.data()!);

      calisthenicsPark.distance = Geolocator.distanceBetween(userLat, userLng,
              calisthenicsPark.latitude!, calisthenicsPark.longitude!) /
          1000;

      final report = await firestore
          .collection("reportsData")
          .where("place_id", isEqualTo: calisthenicsPark.id)
          .get();
      calisthenicsPark.reportCount = report.docs.length;
    } catch (e) {
      log('Error fetching data: $e');
    }
    loading = false;
  }

  @override
  void onInit() async {
    userid = await StorageProvider.getUserToken();
    await getData();
    super.onInit();
  }
}
