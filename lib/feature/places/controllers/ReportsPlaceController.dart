import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pain/feature/places/models/ReportPlaceModel.dart';
import 'package:pain/theme/colors.dart';

import '../../../StorageProvider.dart';
import '../../../widget/BasicLoader.dart';
import '../../../widget/CustomAlertDialog.dart';
import '../../../widget/ToastMessageCustom.dart';

class ReportsPlaceController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  String id = "";
  String name = "";

  bool result = Get.arguments?["result"] ?? false;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  RxList<ReportPlaceModel> _reportPlaceData = <ReportPlaceModel>[].obs;
  List<ReportPlaceModel> get reportPlaceData => _reportPlaceData.value;
  set reportPlaceData(List<ReportPlaceModel> reportPlaceData) =>
      _reportPlaceData.value = reportPlaceData;

  Rx<bool> _loadMore = true.obs;
  bool get loadMore => _loadMore.value;
  set loadMore(bool loadMore) => _loadMore.value = loadMore;

  Rx<bool> _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  set hasMore(bool hasMore) => _hasMore.value = hasMore;

  final ScrollController scrollController = ScrollController();

  String? userid = "";

  int page = 1;
  QueryDocumentSnapshot? documentSnapshot;

  Future onDeleteReport(int index) async {
    try {
      Get.dialog(CustomAlertDialog(
          onPressedno: () {
            Get.back();
          },
          onPressedyes: () async {
            Get.back();
            Get.dialog(BasicLoader());
            ReportPlaceModel data = reportPlaceData[index];
            for (var element in data.media!) {
              await storageRef
                  .child("Reports")
                  .child(data.placeId!)
                  .child(data.userId!)
                  .child(element.idPic!)
                  .delete();
              await storageRef
                  .child("Reports")
                  .child(data.placeId!)
                  .child(data.userId!)
                  .child("thumbnail_" + element.idPic!)
                  .delete();
            }

            await firestore.collection("reportsData").doc(data.id).delete();

            Get.back();

            documentSnapshot = null;
            page = 1;

            await getData();
          },
          backgroundColor: Color.fromRGBO(69, 63, 63, 0.773),
          title: "Do you want to delete this report?",
          fontColor: Color.fromARGB(204, 255, 255, 255),
          fontSize: 20,
          iconColor: Colors.white));
    } catch (e) {
      ToastMessageCustom.ToastMessage("Something went wrong", primaryColor,
          textColor: Colors.white);
    }
  }

  Future getData() async {
    loading = true;
    try {
      final QuerySnapshot<Map<String, dynamic>> data;
      if (documentSnapshot == null) {
        data = await firestore
            .collection('reportsData')
            .orderBy("date", descending: true)
            .where("place_id", isEqualTo: id)
            .limit(10)
            .get();
      } else {
        data = await firestore
            .collection("reportsData")
            .orderBy("date", descending: true)
            .where("place_id", isEqualTo: id)
            .startAfterDocument(documentSnapshot!)
            .limit(10)
            .get();
      }

      if (data.docs.isNotEmpty) {
        List<ReportPlaceModel> tempPayload = List<ReportPlaceModel>.from(
            data.docs.map((e) =>
                ReportPlaceModel.fromJson(json.decode(json.encode(e.data())))));
        for (var element in tempPayload) {
          await firestore
              .collection("usersData")
              .doc(element.userId)
              .get()
              .then(
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

        if (documentSnapshot == null) {
          reportPlaceData = tempPayload;
        } else {
          reportPlaceData.addAll(tempPayload);
        }

        documentSnapshot = data.docs.last;

        hasMore = data.docs.length == 5;

        loadMore = hasMore;
      }
    } catch (e) {}
    loading = false;
  }

  @override
  void onInit() async {
    id = Get.arguments['id'];
    // name = Get.arguments['name'];

    userid = await StorageProvider.getUserToken();

    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (hasMore == true) {
          await getData();
        }
      }
    });

    await getData();
    // TODO: implement onInit
    super.onInit();
  }
}
