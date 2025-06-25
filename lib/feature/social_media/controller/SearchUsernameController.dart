import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/models/UserData.dart';

class SearchUsernameController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<UserData> _userList = <UserData>[].obs;
  List<UserData> get userList => _userList;
  set userList(List<UserData> userList) => _userList.value = userList;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<TextEditingController> _searchValue = TextEditingController().obs;
  TextEditingController get searchValue => _searchValue.value;
  set searchValue(TextEditingController searchValue) =>
      _searchValue.value = searchValue;
  Rx<QueryDocumentSnapshot?> documentSnapshot = (null as QueryDocumentSnapshot?).obs;

  Rx<bool> _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  set hasMore(bool hasMore) => _hasMore.value = hasMore;

  Rx<bool> _loadMore = true.obs;
  bool get loadMore => _loadMore.value;
  set loadMore(bool loadMore) => _loadMore.value = loadMore;

  Future getUserList({String? value}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> data;
      if (documentSnapshot.value == null) {
        data = await firestore
            .collection("usersData")
            .where("keywords", arrayContains: value)
            .orderBy("name", descending: true)
            .limit(10)
            .get();
      } else {
        data = await firestore
            .collection("usersData")
            .where("keywords", arrayContains: value)
            .orderBy("name", descending: true)
            .startAfterDocument(documentSnapshot.value!)
            .limit(10)
            .get();
      }

      if (data.docs.isNotEmpty) {
        List<UserData> tempPayload = List<UserData>.from(data.docs
            .map((e) => UserData.fromJson(json.decode(json.encode(e.data())))));

        if (documentSnapshot.value == null) {
          userList = tempPayload;
        } else {
          userList.addAll(tempPayload);
        }

        documentSnapshot.value = data.docs.length == 10 ? data.docs.last : null;
      }

      hasMore = data.docs.length == 10;
      loadMore = hasMore;
    } catch (e) {
      print(e);
    }
    loading = false;
  }
}
