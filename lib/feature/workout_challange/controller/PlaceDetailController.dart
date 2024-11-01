import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pain/model/CalisthenicsPark.dart';

class Placedetailcontroller extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<CalisthenicsPark> _placeData = CalisthenicsPark().obs;
  CalisthenicsPark get placeData => _placeData.value;
  set placeData(CalisthenicsPark placeData) => _placeData.value = placeData;

  Future getPlaceData() async {
    try {
      final data = await firestore
          .collection("placesData")
          .doc(Get.parameters['id'])
          .get();

      placeData = CalisthenicsPark.fromJson(data.data()!);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    loading = true;
    await getPlaceData();
    loading = false;
    super.onInit();
  }
}
