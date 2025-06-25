import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pain/model/CommentPost.dart';
import 'package:pain/model/UserPost.dart';
import 'package:pain/widget/BasicLoader.dart';

import '../../../StorageProvider.dart';
import '../../../widget/CustomAlertDialog.dart';
import '../../../widget/ToastMessageCustom.dart';

class Detailsocialmediacontroller extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    // TODO: implement onInit
    userid = await StorageProvider.getUserToken();
    idPost = Get.arguments["id"];
    await getData();
    super.onInit();
  }

  final GlobalKey<FormBuilderState> form = GlobalKey();

  Rx<TextEditingController> _comment = TextEditingController().obs;
  TextEditingController get comment => _comment.value;
  set comment(TextEditingController comment) => _comment.value = comment;

  final ScrollController scrollController = ScrollController();

  bool anyChange = false;

  String? userid;
  String? idPost;

  RxList<CommentPost> _commentData = <CommentPost>[].obs;
  List<CommentPost> get commentData => _commentData;
  set commentData(List<CommentPost> commentData) =>
      _commentData.value = commentData;

  Rx<bool> _loading = true.obs;
  bool get loading => _loading.value;
  set loading(bool loading) => _loading.value = loading;

  Rx<bool> _loadingComment = true.obs;
  bool get loadingComment => _loadingComment.value;
  set loadingComment(bool loadingComment) =>
      _loadingComment.value = loadingComment;

  Rx<bool> _loadMore = true.obs;
  bool get loadMore => _loadMore.value;
  set loadMore(bool loadMore) => _loadMore.value = loadMore;

  Rx<bool> _hasMore = false.obs;
  bool get hasMore => _hasMore.value;
  set hasMore(bool hasMore) => _hasMore.value = hasMore;

  Rx<UserPost> _postData = UserPost().obs;
  UserPost get postData => _postData.value;
  set postData(UserPost postData) => _postData.value = postData;

  QueryDocumentSnapshot? documentSnapshot;

  Future getData() async {
    try {
      loading = true;
      await getPostData();
      await getPostComment(isRefresh: true);
      loading = false;
    } catch (e) {
      log(e.toString());
    }
  }

  Future addComment(context) async {
    if (comment.text.isNotEmpty) {
      try {
        FocusScope.of(context).requestFocus(FocusNode());
        Get.dialog(BasicLoader());
        String id = firestore.collection("commentSocialMediaData").doc().id;
        await firestore.collection("commentSocialMediaData").doc(id).set({
          "idUser": userid,
          "idPost": idPost,
          "id": id,
          "username": "",
          "profilePic": "",
          "comment": comment.text,
          "date": DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(DateTime.now())
              .toString()
        }).whenComplete(() async {
          comment.text = "";
          await firestore
              .collection("commentSocialMediaData")
              .where("idPost", isEqualTo: idPost)
              .get()
              .then((value) async {
            await firestore.collection("socialMediaData").doc(idPost).set(
                {"comment": value.docs.length}, SetOptions(merge: true)).then(
              (value) async {
                final dataLike = await firestore
                    .collection("socialMediaData")
                    .doc(idPost)
                    .get();
                postData = postData.copyWith(
                  comment: dataLike.data()?['comment'],
                );
              },
            );
          });
          await getPostComment(isRefresh: true);
          anyChange = true;
          Get.back();
        });
      } catch (e) {}
    } else {
      ToastMessageCustom.ToastMessage(
          "Please add a comment", Color.fromARGB(204, 245, 60, 13));
    }
  }

  Future getPostData({bool isRefresh = false}) async {
    try {
      final postResult =
          await firestore.collection("socialMediaData").doc(idPost).get();

      postData = UserPost.fromJson(json.decode(json.encode(postResult.data())));

      postData = postData.copyWith(
        liked: postResult.data()?["liked"]?[userid] != null ? true : false,
      );

      await firestore
          .collection("usersData")
          .doc(postData.idUser)
          .get()
          .then((value) {
        postData = postData.copyWith(
          username: value.data()!["username"],
          profilepicture: value.data()!["photo_profile"],
        );
      });
    } catch (e) {
      print(e);
    }
  }

  Future getPostComment({bool isRefresh = false}) async {
    try {
      loadMore = true;
      loadingComment = isRefresh;
      if (isRefresh) {
        List<CommentPost> temp = [];
        commentData = temp;
        hasMore = false;
        documentSnapshot = null;
      }
      final QuerySnapshot<Map<String, dynamic>> data;
      if (documentSnapshot == null) {
        data = await firestore
            .collection("commentSocialMediaData")
            .where("idPost", isEqualTo: idPost)
            .orderBy("date", descending: true)
            .limit(10)
            .get();
      } else {
        data = await firestore
            .collection("commentSocialMediaData")
            .where("idPost", isEqualTo: idPost)
            .orderBy("date", descending: true)
            .startAfterDocument(documentSnapshot!)
            .limit(10)
            .get();
      }

      if (data.docs.isNotEmpty) {
        List<CommentPost> tempPayload = List<CommentPost>.from(data.docs.map(
            (e) => CommentPost.fromJson(json.decode(json.encode(e.data())))));

        for (var element in tempPayload) {
          await firestore
              .collection("usersData")
              .doc(element.idUser)
              .get()
              .then(
            (value) {
              element.profilePic = value.data()?['photo_profile'];
              element.username = value.data()?['username'];
            },
          );
        }

        if (documentSnapshot == null) {
          commentData = tempPayload;
        } else {
          commentData.addAll(tempPayload);
        }

        documentSnapshot = data.docs.last;
      }

      hasMore = data.docs.length == 5;

      loadMore = hasMore;
    } catch (e) {
      print(e);
    }
    loadingComment = false;
  }

  Future like() async {
    final data = firestore.collection("socialMediaData").doc(idPost);

    final userid = await StorageProvider.getUserToken();

    final result = await data.get();

    result.data()?["liked"]?[userid] != null
        ? await data.update({"liked.$userid": FieldValue.delete()})
        : await data.set({
            "liked": {userid: "liked"}
          }, SetOptions(merge: true));

    final result_2 = await data.get();

    int likeData =
        (result_2.data()?["liked"] as Map<String, dynamic>).entries.length;

    await Future.wait(
      [
        data.set({"like": likeData}, SetOptions(merge: true)),
      ],
    );

    postData = postData.copyWith(
      liked: result.data()?["liked"]?[userid] != null ? false : true,
      like: likeData,
    );
  }

  Future deletePost() async {
    final userid = await StorageProvider.getUserToken();
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          Get.back();
          Get.dialog(BasicLoader());
          await Future.wait([
            storageRef.child("$userid").child(idPost ?? "").delete(),
            firestore.collection("socialMediaData").doc(idPost).delete()
          ]);

          final result = await firestore
              .collection("socialMediaData")
              .where("idUser", isEqualTo: userid)
              .get();
          await firestore
              .collection("usersData")
              .doc(userid)
              .update({"post": result.docs.length});
          Get.back();
          anyChange = true;
          Get.back(result: anyChange);
        },
        backgroundColor: Color.fromRGBO(69, 63, 63, 0.773),
        title: "Do you want to delete this post?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
  }

  Future deleteComment(String idComment) async {
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          try {
            Get.back();
            Get.dialog(BasicLoader());

            await firestore
                .collection("commentSocialMediaData")
                .doc(idComment)
                .delete()
                .whenComplete(() async {
              await firestore
                  .collection("commentSocialMediaData")
                  .where("idPost", isEqualTo: idPost)
                  .get()
                  .then((value) async {
                await firestore.collection("socialMediaData").doc(idPost).set(
                    {"comment": value.docs.length},
                    SetOptions(merge: true)).then(
                  (value) async {
                    final dataLike = await firestore
                        .collection("socialMediaData")
                        .doc(idPost)
                        .get();
                    postData = postData.copyWith(
                      comment: dataLike.data()?['comment'],
                    );
                  },
                );
              });
            });

            anyChange = true;

            getPostComment(isRefresh: true);
          } catch (e) {
            log(e.toString());
          }
          Get.back();
        },
        backgroundColor: Color.fromRGBO(69, 63, 63, 0.773),
        title: "Do you want to delete this post?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
  }
}
