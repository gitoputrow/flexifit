import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../model/CalisthenicsPark.dart';

class PlacesController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<bool> _loadingPlaces = true.obs;
  bool get loadingPlaces => _loadingPlaces.value;
  set loadingPlaces(bool loadingPlaces) => _loadingPlaces.value = loadingPlaces;

  Rx<String> _selectedProvince = "DKI Jakarta".obs;
  String get selectedProvince => _selectedProvince.value;
  set selectedProvince(String selectedProvince) =>
      _selectedProvince.value = selectedProvince;

  List<String> items = [];

  RxList<CalisthenicsPark> _calisthenicsParkData = <CalisthenicsPark>[].obs;
  List<CalisthenicsPark> get calisthenicsParkData =>
      _calisthenicsParkData.value;
  set calisthenicsParkData(List<CalisthenicsPark> calisthenicsParkData) =>
      _calisthenicsParkData.value = calisthenicsParkData;

  Future getProvinceList({bool isRefresh = false}) async {
    try {
      final data =
          await firestore.collection("provinceData").doc("ListProvince").get();

      items = List.from(data.data()!["data"]);

      selectedProvince = items.first;
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  Future<void> getCalisthenicsParkData() async {
    try {
      loadingPlaces = true;
      // Step 1: Get the user's current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double userLat = position.latitude;
      double userLng = position.longitude;

      final data = await firestore
          .collection("placesData")
          .where('category', isEqualTo: "calisthenics")
          .where('province', isEqualTo: selectedProvince)
          .get();

      calisthenicsParkData = List.from(
          data.docs.map((e) => CalisthenicsPark.fromJson(e.data())).toList());

      for (var i in calisthenicsParkData) {
        i.distance = Geolocator.distanceBetween(
                userLat, userLng, i.latitude!, i.longitude!) /
            1000;
      }

      calisthenicsParkData.sort((a, b) => a.distance!.compareTo(b.distance!));
    } catch (e) {
      log('Error fetching data: $e');
    }
    loadingPlaces = false;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    loading = true;
    await getProvinceList();
    await getCalisthenicsParkData();
    loading = false;
    super.onInit();
  }
}
