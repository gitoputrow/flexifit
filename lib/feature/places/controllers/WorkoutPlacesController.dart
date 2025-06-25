import 'dart:developer' as dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pain/services/location/location_service.dart';

import '../models/WorkoutPlacesModel.dart';
import '../models/CityModel.dart';

class WorkoutPlacesController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<bool> _locError = false.obs;
  bool get locError => _locError.value;
  set locError(bool locError) => _locError.value = locError;

  Rx<bool> _loadingPlaces = true.obs;
  bool get loadingPlaces => _loadingPlaces.value;
  set loadingPlaces(bool loadingPlaces) => _loadingPlaces.value = loadingPlaces;

  Rx<CityModel> _selectedCity = CityModel().obs;
  CityModel get selectedCity => _selectedCity.value;
  set selectedCity(CityModel selectedCity) =>
      _selectedCity.value = selectedCity;

  List<CityModel> items = [];

  RxList<WorkoutPlacesModel> _calisthenicsParkData = <WorkoutPlacesModel>[].obs;
  List<WorkoutPlacesModel> get calisthenicsParkData =>
      _calisthenicsParkData.value;
  set calisthenicsParkData(List<WorkoutPlacesModel> calisthenicsParkData) =>
      _calisthenicsParkData.value = calisthenicsParkData;

  Future getCityList({bool isRefresh = false}) async {
    try {
      final data = await firestore.collection("cityData").get();

      items = List.from(
          data.docs.map((element) => CityModel.fromJson(element.data())));

      selectedCity = items.first;
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  Future<void> getCalisthenicsParkData() async {
    try {
      await LocationService().requestPermission();
      locError = false;
      loadingPlaces = true;
      // Step 1: Get the user's current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double userLat = position.latitude;
      double userLng = position.longitude;

      final data = await firestore
          .collection("placesData")
          .where('city.id', isEqualTo: selectedCity.id)
          .get();

      calisthenicsParkData = List.from(
          data.docs.map((e) => WorkoutPlacesModel.fromJson(e.data())).toList());

      for (var i in calisthenicsParkData) {
        i.distance = Geolocator.distanceBetween(
                userLat, userLng, i.latitude!, i.longitude!) /
            1000;
      }

      calisthenicsParkData.sort((a, b) => a.distance!.compareTo(b.distance!));

      calisthenicsParkData.forEach(
        (element) {
          dev.log('Fetched ${element.toJson()}');
        },
      );
    } catch (e) {
      dev.log('Error fetching data: $e');
      locError = true;
    }
    loadingPlaces = false;
  }

  @override
  void onInit() async {
    // TODO: implement onInit

    loading = true;
    await getCityList();
    await getCalisthenicsParkData();
    loading = false;
    super.onInit();
  }
}
