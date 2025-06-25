import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pain/theme/colors.dart';

import '../../../StorageProvider.dart';
import '../../authentification/models/UserData.dart';
import '../../authentification/view/HomeScreen.dart';
import '../../../widget/BasicLoader.dart';
import '../../../widget/CustomAlertDialog.dart';
import '../../../widget/ToastMessageCustom.dart';

class EditPasswordController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Rx<UserData?> _user = (null as UserData?).obs;
  UserData? get user => _user.value;
  set user(UserData? user) => _user.value = user;

  Rx<TextEditingController> _oldPass = TextEditingController().obs;
  TextEditingController get oldPass => _oldPass.value;
  set oldPass(TextEditingController oldPass) => _oldPass.value = oldPass;

  Rx<TextEditingController> _newPass = TextEditingController().obs;
  TextEditingController get newPass => _newPass.value;
  set newPass(TextEditingController newPass) => _newPass.value = newPass;

  Rx<TextEditingController> _cNewPass = TextEditingController().obs;
  TextEditingController get cNewPass => _cNewPass.value;
  set cNewPass(TextEditingController cNewPass) => _cNewPass.value = cNewPass;

  Rx<bool> _buttonPermEPass = false.obs;
  bool get buttonPermEPass => _buttonPermEPass.value;
  set buttonPermEPass(bool buttonPermEPass) =>
      _buttonPermEPass.value = buttonPermEPass;

  Future changePassword() async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: user?.email ?? '', password: oldPass.text);
      if (cNewPass.text == newPass.text) {
        Get.dialog(CustomAlertDialog(
            onPressedno: () {
              Get.back();
            },
            onPressedyes: () async {
              Get.back();
              try {
                Get.dialog(BasicLoader());
                final id = await StorageProvider.getUserToken();
                await firestore
                    .collection("usersData")
                    .doc(id)
                    .update({"pass": newPass.text});
                ToastMessageCustom.ToastMessage(
                    "Password Changed", Color.fromRGBO(10, 12, 13, 0.8));
                Future.delayed(Duration(seconds: 1));
                Get.offAllNamed("/dashboard", arguments: 3);
              } catch (e) {}
            },
            backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
            title: "Do you want to Discard Changes?",
            fontColor: Color.fromARGB(204, 255, 255, 255),
            fontSize: 20,
            iconColor: Colors.white));
      } else {
        ToastMessageCustom.ToastMessage(
            "Password Doesn't Match", Color.fromRGBO(170, 5, 27, 1));
      }
    } catch (e) {
      ToastMessageCustom.ToastMessage("Wrong Old Password", primaryDarkColor);
    }
  }

  void discardEPass() {
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          Get.back();
          cNewPass.text = "";
          newPass.text = "";
          oldPass.text = "";
        },
        backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
        title: "Do you want to Discard Changes?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
  }

  void buttonPermissionEPass() {
    if (newPass.text.isNotEmpty &&
        cNewPass.text.isNotEmpty &&
        oldPass.text.isNotEmpty) {
      buttonPermEPass = true;
    } else {
      buttonPermEPass = false;
    }
  }

  @override
  void onInit() async {
    final userid = await StorageProvider.getUserToken();
    try {
      final data = await firestore.collection("usersData").doc(userid).get();
      user = UserData.fromJson(json.decode(json.encode(data.data())));
    } catch (e) {
      Get.offAll(HomeScreen());
    }

    super.onInit();
  }
}
