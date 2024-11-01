import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pain/model/CalisthenicsPark.dart';

class PlacesDetailController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<CalisthenicsPark> _calisthenicsPark = CalisthenicsPark().obs;
  CalisthenicsPark get calisthenicsPark => _calisthenicsPark.value;
  set calisthenicsPark(CalisthenicsPark calisthenicsPark) =>
      _calisthenicsPark.value = calisthenicsPark;

  Future<void> getCalisthenicsParkData() async {
    loading = true;
    try {
      // Step 1: Get the user's current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double userLat = position.latitude;
      double userLng = position.longitude;

      final data = await firestore
          .collection("placesData")
          .doc(Get.arguments['id'])
          .get();

      calisthenicsPark = CalisthenicsPark.fromJson(data.data()!);

      calisthenicsPark.distance = Geolocator.distanceBetween(userLat, userLng,
              calisthenicsPark.latitude!, calisthenicsPark.longitude!) /
          1000;
    } catch (e) {
      log('Error fetching data: $e');
    }
    loading = false;
  }

  @override
  void onInit() async {
    await getCalisthenicsParkData();
    super.onInit();
  }
}
