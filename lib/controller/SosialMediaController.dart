import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pain/model/UserPost.dart';

import '../model/CommentPost.dart';
import '../model/UserData.dart';
import '../widget/BasicLoader.dart';
import '../widget/CustomAlertDialog.dart';
import '../widget/ToastMessageCustom.dart';

class SosialMediaController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase().ref();

  Rx<TextEditingController> _caption = TextEditingController().obs;
  TextEditingController get caption => _caption.value;
  set caption(TextEditingController caption) => _caption.value = caption;

  Rx<TextEditingController> _comment = TextEditingController().obs;
  TextEditingController get comment => _comment.value;
  set comment(TextEditingController comment) => _comment.value = comment;

  String userid = "";
  String postUserId = "";

  dynamic argumentData = Get.arguments;

  Rx<File?> _imageFile = (null as File?).obs;
  File? get imageFile => _imageFile.value;
  set imageFile(File? imageFile) => _imageFile.value = imageFile;

  Rx<String?> _imageSource = "".obs;
  String? get imageSource => _imageSource.value;
  set imageSource(String? imageFile) => _imageSource.value = imageSource;

  Rx<String?> _mode = "".obs;
  String? get mode => _mode.value;
  set mode(String? mode) => _mode.value = mode;

  Rx<String?> _userProfileId = "".obs;
  String? get userProfileId => _userProfileId.value;
  set userProfileId(String? userProfileId) => _userProfileId.value = userProfileId;

  Rx<bool?> _loadingComment = true.obs;
  bool? get loadingComment => _loadingComment.value;
  set loadingComment(bool? loadingComment) => _loadingComment.value = loadingComment;

  Rx<bool?> _loadingUserData = true.obs;
  bool? get loadingUserData => _loadingUserData.value;
  set loadingUserData(bool? loadingUserData) => _loadingUserData.value = loadingUserData;

  Rx<UserPost?> _userPost = (null as UserPost?).obs;
  UserPost? get userPost => _userPost.value;
  set userPost(UserPost? userPost) => _userPost.value = userPost;

  RxList<UserPost> _userPostData = <UserPost>[].obs;
  List<UserPost> get userPostData => _userPostData.value;
  set userPostData(List<UserPost> userPostData) => _userPostData.value = userPostData;

  Rx<UserData?> _userData = UserData().obs;
  UserData? get userData => _userData.value;
  set userData(UserData? userData) => _userData.value = userData;

  RxList<CommentPost> _commentPost = <CommentPost>[].obs;
  List<CommentPost> get commentPost => _commentPost.value;
  set commentPost(List<CommentPost> commentPost) => _commentPost.value = commentPost;

  Future uploadPost() async {
    try {
      Get.dialog(BasicLoader());
      Map imageFolder = {};
      final idPic = "post_${DateFormat('dd-MM-y_H:mm:ss').format(DateTime.now())}|${userid}";
      print(idPic);
      await storageRef.child(userid).child(idPic).putFile(imageFile!).whenComplete(() async =>
          await storageRef.child(userid).child(idPic).getDownloadURL().then((value) async {
            await database.child("SosialMedia").child(userid).child(idPic).set({
              "imageSource": value,
              "username": "",
              "profilepicture": "",
              "caption": caption.text,
              "date": DateFormat('dd-MM-y H:mm:ss').format(DateTime.now()).toString(),
              "like": 0,
              "dislike": 0,
              "comment": 0,
              "id": idPic
            }).whenComplete(() => Get.offAllNamed("/dashboard", arguments: 2));
          }));
    } catch (e) {}
  }

  Future deletePost() async {
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          Get.back();
          Get.dialog(BasicLoader());
          await storageRef.child("$userid").child(userPost!.id!).delete().whenComplete(() async =>
              await database.child("SosialMedia").child(userid).child(userPost!.id!).remove());
          Get.back();
          Get.offAllNamed("/dashboard", arguments: 2);
        },
        backgroundColor: Color.fromRGBO(69, 63, 63, 0.773),
        title: "Do you want to delete this post?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
  }

  Rx<String> testa = "Discard".obs;

  Future like(String userId, String idPost) async {
    final dataPost = await database.child("SosialMedia").child(userId).child(idPost).get();
    if (dataPost.child("liked").child(userid).exists) {
      await database
          .child("SosialMedia")
          .child(userId)
          .child(idPost)
          .child("liked")
          .child(userid)
          .remove()
          .whenComplete(() {
        if (mode == "postdetail") {
          userPost!.liked = false;
          userPost!.like = dataPost.child("liked").children.length - 1;
          testa.value = "b";
        } else {
          userPostData[userPostData.indexWhere((element) => element.id! == idPost)].liked = false;
          userPostData[userPostData.indexWhere((element) => element.id! == idPost)].like =
              dataPost.child("liked").children.length - 1;
          testa.value =
              "b${userPostData[userPostData.indexWhere((element) => element.id! == idPost)].id}";
        }
      });
    } else {
      await database
          .child("SosialMedia")
          .child(userId)
          .child(idPost)
          .child("liked")
          .child(userid)
          .set("liked")
          .whenComplete(() {
        if (mode == "postdetail") {
          userPost!.liked = true;
          userPost!.like = dataPost.child("liked").children.length + 1;
          testa.value = "a";
        } else {
          userPostData[userPostData.indexWhere((element) => element.id! == idPost)].liked = true;
          userPostData[userPostData.indexWhere((element) => element.id! == idPost)].like =
              dataPost.child("liked").children.length + 1;
          testa.value =
              "a${userPostData[userPostData.indexWhere((element) => element.id! == idPost)].id}";
        }
      });
    }
  }

  Future getUserSosmedData() async {
    try {
      userPostData.clear();
      loadingUserData = true;
      final dataUser = await database.child("userDatabase").child("$userProfileId").get();
      userData = UserData.fromJson(json.decode(json.encode(dataUser.value)));
      final dataSosmed = await database.get();
      if (dataSosmed.child("SosialMedia").child(userProfileId!).exists) {
        final dataPostUser = await database.child("SosialMedia").child(userProfileId!).get();
        for (var data in dataPostUser.children) {
          userPostData.add(UserPost.fromJson(json.decode(json.encode(data.value))));
        }
        for (var item in userPostData) {
          item.username = userData!.username;
          item.profilepicture = userData!.photoprofile;
          final dataPost = await database
              .child("SosialMedia")
              .child(item.id!.substring(item.id!.indexOf("|") + 1))
              .child(item.id!)
              .get();
          if (dataPost.child("liked").exists) {
            item.liked = dataPost.child("liked").child(userid).exists;
            item.like = dataPost.child("liked").children.length;
          }
          if (dataPost.child("commented").exists) {
            item.comment = dataPost.child("commented").children.length;
          }
        }
      }
      loadingUserData = false;
    } catch (e) {}
  }

  Future deleteComment(String id, context) async {
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          Get.back();
          Get.dialog(BasicLoader());
          await database
              .child("SosialMedia")
              .child(userPost!.id!.substring(userPost!.id!.indexOf("|") + 1))
              .child(userPost!.id!)
              .child("commented")
              .child(id)
              .remove()
              .whenComplete(() async => await getPostComment());
          Get.back();
        },
        backgroundColor: Color.fromRGBO(69, 63, 63, 0.773),
        title: "Do you want to delete this comment?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
    FocusScope.of(context).requestFocus(FocusNode());
    testa.value = "adsssada";
  }

  Future addComment(context) async {
    if (comment.text.isNotEmpty) {
      try {
        Get.dialog(BasicLoader());
        final idcomment =
            "comment_${DateFormat('dd-MM-y_H:mm:ss').format(DateTime.now())}|${userid}";
        await database
            .child("SosialMedia")
            .child(userPost!.id!.substring(userPost!.id!.indexOf("|") + 1))
            .child(userPost!.id!)
            .child("commented")
            .child(idcomment)
            .set({
          "id": idcomment,
          "username": "",
          "profilePic": "",
          "comment": comment.text,
          "date": DateFormat('dd-MM-y H:mm:ss').format(DateTime.now()).toString()
        }).whenComplete(() async {
          comment.text = "";
          FocusScope.of(context).requestFocus(FocusNode());
          await getPostComment();
          Get.back();
        });
      } catch (e) {}
    } else {
      ToastMessageCustom.ToastMessage("Please add a comment", Color.fromARGB(204, 245, 60, 13));
    }
    testa.value = "adada";
  }

  Future getPostComment() async {
    try {
      commentPost.clear();
      loadingComment = true;
      final postData = await database
          .child("SosialMedia")
          .child(userPost!.id!.substring(userPost!.id!.indexOf("|") + 1))
          .child(userPost!.id!)
          .get();
      if (postData.child("commented").exists) {
        userPost!.comment = postData.child("commented").children.length;
        postData.child("commented").children.forEach((element) {
          commentPost.add(CommentPost.fromJson(json.decode(json.encode(element.value))));
        });
        for (var i in commentPost) {
          final data = await database
              .child("userDatabase")
              .child(i.id!.substring(i.id!.indexOf("|") + 1))
              .get();
          i.profilePic = data.child("photoprofile").value.toString();
          i.username = data.child("username").value.toString();
        }

        commentPost.sort(
          (b, a) => a.date!.compareTo(b.date!),
        );
        print("objectdada");
      }
      loadingComment = false;
    } catch (e) {
      loadingComment = false;
    }
  }

  @override
  void onInit() async {
    print("masukk");
    userid = argumentData[0];
    imageFile = argumentData[1]["img_file"] ?? null;
    userPost = argumentData[1]["post_data"] ?? null;
    userProfileId = argumentData[1]["user_post"] ?? "";
    mode = argumentData[2];
    mode == "postdetail" ? await getPostComment() : mode == "" ? null : await getUserSosmedData();
    print(mode);
    super.onInit();
  }
}
