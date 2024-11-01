import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pain/model/CalisthenicsPark.dart';

import '../../../model/Challange.dart';

class WorkoutChallangeController extends GetxController
    with GetTickerProviderStateMixin{
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  late TabController tabController;

  QueryDocumentSnapshot? documentSnapshotPlaces;

  RxList<Challange> _challangeData = <Challange>[].obs;
  List<Challange> get challangeData => _challangeData.value;
  set challangeData(List<Challange> challangeData) =>
      _challangeData.value = challangeData;

  Rx<bool> _loadMore = true.obs;
  bool get loadMore => _loadMore.value;
  set loadMore(bool loadMore) => _loadMore.value = loadMore;

  Rx<bool> _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  set hasMore(bool hasMore) => _hasMore.value = hasMore;

  Future getChallengeData() async {
    loading = true;
    try {
      final data = await database.child("ChallengeWO").get();
      for (var i in data.children) {
        challangeData
            .add(Challange.fromJson(json.decode(json.encode(i.value))));
      }
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  


  @override
  void onInit() async {
    // TODO: implement onInit
    await getChallengeData();
    super.onInit();
  }
}
