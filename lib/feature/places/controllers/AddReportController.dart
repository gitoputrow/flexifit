import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pain/StorageProvider.dart';
import 'package:pain/feature/places/controllers/PlacesDetailController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/BasicLoader.dart';
import 'package:pain/widget/MediaWidget.dart';

import '../../../widget/CustomAlertDialog.dart';
import '../../../widget/ToastMessageCustom.dart';

class AddReportController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  @override
  void onInit() async {
    // TODO: implement onInit
    place_id = Get.arguments['id'];
    name = Get.arguments['name'];
    user_id = (await StorageProvider.getUserToken())!;
    super.onInit();
  }

  final GlobalKey<FormBuilderState> form = GlobalKey();

  String place_id = "";
  String user_id = "";
  String name = "";

  void submit() {
    if (!form.currentState!.saveAndValidate()) {
      return;
    }
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          try {
            Get.back();
            Get.dialog(BasicLoader());

            String id =
                "${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())}_${StorageProvider.getUserToken()}";

            List<Map> media = [];

            for (var i = 0; i < form.currentState?.value['media'].length; i++) {
              DateTime date = DateTime.now();
              await storageRef
                  .child("Reports")
                  .child(place_id)
                  .child(user_id)
                  .child("${place_id}_${user_id}_$date")
                  .putFile(File(form.currentState?.value['media'][i]['path']))
                  .whenComplete(
                    () async => await storageRef
                        .child("Reports")
                        .child(place_id)
                        .child(user_id)
                        .child("${place_id}_${user_id}_$date")
                        .getDownloadURL()
                        .then((value_path) async {
                      await storageRef
                          .child("Reports")
                          .child(place_id)
                          .child(user_id)
                          .child("thumbnail_${place_id}_${user_id}_$date")
                          .putFile(File(form.currentState?.value['media'][i]
                              ['thumbnail']))
                          .whenComplete(() async => await storageRef
                                  .child("Reports")
                                  .child(place_id)
                                  .child(user_id)
                                  .child(
                                      "thumbnail_${place_id}_${user_id}_$date")
                                  .getDownloadURL()
                                  .then(
                                (value) {
                                  media.add({
                                    "path": value_path,
                                    "id_pic": "${place_id}_${user_id}_$date",
                                    "thumbnail": value,
                                    "type": (form.currentState?.value['media']
                                            [i]['type'] as MediaType)
                                        .name,
                                  });
                                },
                              ));
                    }),
                  );
            }

            await firestore.collection("reportsData").add({
              "media": media,
              "place_id": place_id,
              "user_id": user_id,
              "date": DateTime.now().millisecondsSinceEpoch,
              "desc": form.currentState?.value['desc'],
            }).then((value) async {
              await firestore.collection("reportsData").doc(value.id).update({
                "id": value.id,
              });
            });
            Get.back();
            Get.offNamed("/placereportpage", arguments: {
              "id": place_id,
              "result": true,
            });
            ToastMessageCustom.ToastMessage(
                "Thank You For Your Report", tertiaryColor,
                textColor: Colors.white);
            PlacesDetailController c = Get.find();
            await c.getData();
          } catch (e) {
            print(e);
          }
        },
        backgroundColor: tertiaryColor.withOpacity(0.9),
        title: "Do you want to send this report?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
  }
}
