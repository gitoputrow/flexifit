import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pain/StorageProvider.dart';

import '../../../widget/BasicLoader.dart';

class AddPostController extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<TextEditingController> _caption = TextEditingController().obs;
  TextEditingController get caption => _caption.value;
  set caption(TextEditingController caption) => _caption.value = caption;

  File? imageFile = Get.arguments?["img_file"];
  // File? get imageFile => _imageFile.value;
  // set imageFile(File? imageFile) => _imageFile.value = imageFile;

  Future uploadPost() async {
    try {
      Get.dialog(BasicLoader());
      final userid = await StorageProvider.getUserToken();
      final date = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
      final idPic = "post_$date|${userid}";

      await storageRef
          .child(userid!)
          .child(idPic)
          .putFile(imageFile!)
          .whenComplete(() async => await storageRef
                  .child(userid)
                  .child(idPic)
                  .getDownloadURL()
                  .then((value) async {
                await firestore.collection("socialMediaData").doc(idPic).set({
                  "imageSource": value,
                  "username": "",
                  "idUser": userid,
                  "id": idPic,
                  "profilepicture": "",
                  "caption": caption.text,
                  "date": date,
                  "like": 0,
                  "dislike": 0,
                  "comment": 0,
                }).then(
                  (value) {
                    Get.offAllNamed("/dashboard", arguments: 2);
                  },
                );
                // await database.child("SosialMedia").child(idPic).set({
                //   "imageSource": value,
                //   "username": "",
                //   "idUser": userid,
                //   "profilepicture": "",
                //   "caption": caption.text,
                //   "date": DateFormat('yyyy-MM-dd HH:mm:ss')
                //       .format(DateTime.now())
                //       .toString(),
                //   "like": 0,
                //   "dislike": 0,
                //   "comment": 0,
                //   "id": idPic
                // }).whenComplete(
                //     () => Get.offAllNamed("/dashboard", arguments: 2));
              }));
    } catch (e) {
      print(e);
    }
  }
}
