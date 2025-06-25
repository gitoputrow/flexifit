import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/UserPost.dart';
import '../../authentification/models/UserData.dart';
import '../../authentification/view/HomeScreen.dart';

class SocialMediaProfileController extends GetxController
    with GetTickerProviderStateMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Rx<UserData?> _user = (null as UserData?).obs;
  UserData? get user => _user.value;
  set user(UserData? user) => _user.value = user;

  String idUser = "";

  late TabController tabController;

  RxList<UserPost> _userPostData = <UserPost>[].obs;
  List<UserPost> get userPostData => _userPostData;
  set userPostData(List<UserPost> userPostData) =>
      _userPostData.value = userPostData;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<bool> _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  set hasMore(bool hasMore) => _hasMore.value = hasMore;

  Rx<bool> _loadMore = true.obs;
  bool get loadMore => _loadMore.value;
  set loadMore(bool loadMore) => _loadMore.value = loadMore;

  QueryDocumentSnapshot? documentSnapshot;

  Future getData() async {
    loading = true;
    try {
      await Future.wait([getUserData(), getPostData()]);
    } catch (e) {
      Get.offAll(HomeScreen());
    }
    loading = false;
  }

  Future getUserData() async {
    try {
      final data = await firestore.collection("usersData").doc(idUser).get();
      user = UserData.fromJson(json.decode(json.encode(data.data())));
      for (var el in user!.recordChallengeData!){
        await firestore.collection('challengeData').doc(el.id).get().then((value) => el.url = value.data()?['picture']);
      }
    } catch (e) {
      Get.offAll(HomeScreen());
    }
  }

  Future getPostData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> data;
      if (documentSnapshot == null) {
        data = await firestore
            .collection("socialMediaData")
            .where("idUser", isEqualTo: idUser)
            .orderBy("date", descending: true)
            .limit(10)
            .get();
      } else {
        data = await firestore
            .collection("socialMediaData")
            .where("idUser", isEqualTo: idUser)
            .orderBy("date", descending: true)
            .startAfterDocument(documentSnapshot!)
            .limit(10)
            .get();
      }

      if (data.docs.isNotEmpty) {
        List<UserPost> tempPayload = List<UserPost>.from(data.docs
            .map((e) => UserPost.fromJson(json.decode(json.encode(e.data())))));
        if (documentSnapshot == null) {
          userPostData = tempPayload;
        } else {
          userPostData.addAll(tempPayload);
        }

        documentSnapshot = data.docs.last;
      }

      hasMore = data.docs.length == 10;

      loadMore = hasMore;
    } catch (e) {
      Get.offAll(HomeScreen());
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    idUser = Get.arguments['id'];
    tabController = TabController(length: 2, vsync: this);
    await getData();
    super.onInit();
  }
}
