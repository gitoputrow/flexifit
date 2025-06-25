import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../StorageProvider.dart';
import '../../authentification/view/splashscreen.dart';
import '../../../widget/BasicLoader.dart';

class SettingController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future logout() async {
    Get.dialog(BasicLoader());
    await StorageProvider.removeUserToken();
    Get.offAll(SplashScreen());
  }

  Future deleteAccount() async {
    Get.dialog(BasicLoader());

    final userid = await StorageProvider.getUserToken();
    print("$userid/");
    await storageRef.child("$userid").listAll().then((value) {
      value.items.forEach((element) async {
        await storageRef.child(element.fullPath).delete();
      });
    });
    
    await StorageProvider.removeUserToken();
    Get.offAll(SplashScreen());
  }

}