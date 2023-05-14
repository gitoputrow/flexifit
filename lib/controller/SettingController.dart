import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Page/IntroPage/splashscreen.dart';
import '../StorageProvider.dart';
import '../model/UserData.dart';
import '../model/UserPhoto.dart';
import '../widget/BasicLoader.dart';
import '../widget/CustomAlertDialog.dart';
import '../widget/ToastMessageCustom.dart';

class SettingController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  DatabaseReference database = FirebaseDatabase().ref();

  dynamic argumentData = Get.arguments;

  Rx<UserData> _user = UserData().obs;
  UserData get user => _user.value;
  set user(UserData user) => _user.value = user;

  RxList<UserPhoto> _userPhoto = <UserPhoto>[].obs;
  List<UserPhoto> get userPhoto => _userPhoto.value;
  set userPhoto(List<UserPhoto> userPhoto) => _userPhoto.value = userPhoto;

  Rx<TextEditingController> _oldPass = TextEditingController().obs;
  TextEditingController get oldPass => _oldPass.value;
  set oldPass(TextEditingController oldPass) => _oldPass.value = oldPass;

  Rx<TextEditingController> _newPass = TextEditingController().obs;
  TextEditingController get newPass => _newPass.value;
  set newPass(TextEditingController newPass) => _newPass.value = newPass;

  Rx<TextEditingController> _cNewPass = TextEditingController().obs;
  TextEditingController get cNewPass => _cNewPass.value;
  set cNewPass(TextEditingController cNewPass) => _cNewPass.value = cNewPass;

  Rx<TextEditingController> _username = TextEditingController().obs;
  TextEditingController get username => _username.value;
  set username(TextEditingController username) => _username.value = username;

  Rx<TextEditingController> _name = TextEditingController().obs;
  TextEditingController get name => _name.value;
  set name(TextEditingController name) => _name.value = name;

  Rx<TextEditingController> _height = TextEditingController().obs;
  TextEditingController get height => _height.value;
  set height(TextEditingController height) => _height.value = height;

  Rx<TextEditingController> _weight = TextEditingController().obs;
  TextEditingController get weight => _weight.value;
  set weight(TextEditingController weight) => _weight.value = weight;

  Rx<bool> _usernameExist = false.obs;
  bool get usernameExist => _usernameExist.value;
  set usernameExist(bool usernameExist) => _usernameExist.value = usernameExist;

  final List<String> items = [
    "Male",
    "Female",
  ];

  Rx<String> _selectedValue = "".obs;
  String get selectedValue => _selectedValue.value;
  set selectedValue(String selectedValue) => _selectedValue.value = selectedValue;

  Rx<String> _itemSelectedValue = "".obs;
  String get itemSelectedValue => _itemSelectedValue.value;
  set itemSelectedValue(String itemSelectedValue) => _itemSelectedValue.value = itemSelectedValue;

  Rx<bool> _oldPassView = false.obs;
  bool get oldPassView => _oldPassView.value;
  set oldPassView(bool oldPassView) => _oldPassView.value = oldPassView;

  Rx<bool> _newPassView = false.obs;
  bool get newPassView => _newPassView.value;
  set newPassView(bool newPassView) => _newPassView.value = newPassView;

  Rx<bool> _cNewPassView = false.obs;
  bool get cNewPassView => _cNewPassView.value;
  set cNewPassView(bool cNewPassView) => _cNewPassView.value = cNewPassView;

  Rx<bool> _buttonPermEP = false.obs;
  bool get buttonPermEP => _buttonPermEP.value;
  set buttonPermEP(bool buttonPermEP) => _buttonPermEP.value = buttonPermEP;

  Rx<bool> _buttonPermEPass = false.obs;
  bool get buttonPermEPass => _buttonPermEPass.value;
  set buttonPermEPass(bool buttonPermEPass) => _buttonPermEPass.value = buttonPermEPass;

  //Function to logout
  Future logout() async {
    Get.dialog(BasicLoader());
    await StorageProvider.removeUserToken();
    Get.offAll(SplashScreen());
  }

  //Function to delete account
  Future deleteAccount() async {
    Get.dialog(BasicLoader());

    final userid = await StorageProvider.getUserToken();

    for (int i = 0; i < userPhoto.length; i++) {
      await storageRef.child(userid!).child("${userPhoto[i].id}").delete();
    }
    await database.child(userid!).remove();
    await StorageProvider.removeUserToken();
    Get.offAll(SplashScreen());
  }

  Future changePassword() async {
    if (oldPass.text != user.pass) {
      ToastMessageCustom.ToastMessage("Wrong Old Password", Color.fromRGBO(170, 5, 27, 1));
    } else {
      if (oldPass.text == newPass.text) {
        ToastMessageCustom.ToastMessage(
            "New Password Has Already Use", Color.fromRGBO(170, 5, 27, 1));
      } else {
        if (cNewPass.text == newPass.text) {
          try {
            Get.dialog(BasicLoader());
            final id = await StorageProvider.getUserToken();
            await database.child("$id").child("pass").set(cNewPass.text);
            discardEP();
            ToastMessageCustom.ToastMessage("Password Changed", Color.fromRGBO(10, 12, 13, 0.8));
            Future.delayed(Duration(seconds: 1));
            Get.offAllNamed("/dashboard", arguments: 2);
          } catch (e) {}
        } else {
          ToastMessageCustom.ToastMessage("Password Doesn't Match", Color.fromRGBO(170, 5, 27, 1));
        }
      }
    }
  }

  //Function to check if username exist
  Future checkUsername(String username) async {
    final data = await database.get();
    for (var children in data.children) {
      if (username == children.child("username").value.toString()) {
        usernameExist = true;
        break;
      }
    }
  }

  //Function to change user profile information
  Future changeProfile() async {
    try {
      Get.dialog(BasicLoader());
      final id = await StorageProvider.getUserToken();
      final data = await database.get();
      await checkUsername(username.text);
      if (usernameExist == true) {
        Get.back();
        ToastMessageCustom.ToastMessage("Username already taken", Color.fromRGBO(170, 5, 27, 1));
      } else {
        user.username = username.text.isNotEmpty ? username.text : user.username;
        user.name = name.text.isNotEmpty ? name.text : user.name;
        user.height = height.text.isNotEmpty ? height.text : user.height;
        user.weight = weight.text.isNotEmpty ? weight.text : user.weight;
        user.gender = selectedValue != user.gender ? selectedValue.toLowerCase() : user.gender;
        await database.child("$id").child("gender").set(user.gender);
        await database.child("$id").child("name").set(user.name);
        await database.child("$id").child("weight").set(user.weight);
        await database.child("$id").child("height").set(user.height);
        await database.child("$id").child("username").set(user.username);
        discardEP();

        ToastMessageCustom.ToastMessage("Profile Changed", Color.fromRGBO(10, 12, 13, 0.8));
        Timer(Duration(seconds: 3), () {
          Get.offAllNamed("/dashboard", arguments: 2);
        });
      }
    } catch (e) {}
  }

  void getBackEP() {
    print(selectedValue != user.gender);
    if (selectedValue.toLowerCase() != user.gender ||
        username.text.isNotEmpty ||
        name.text.isNotEmpty ||
        height.text.isNotEmpty ||
        weight.text.isNotEmpty) {
      print("object");
      Get.dialog(CustomAlertDialog(
          onPressedno: () {
            Get.back();
          },
          onPressedyes: () async {
            Get.back();
            discardEP();
            Get.back();
          },
          backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
          title: "Are You Sure Want to Quit?\nyour changes will not be saved",
          fontColor: Color.fromARGB(204, 255, 255, 255),
          fontSize: 20,
          iconColor: Colors.white));
    } else {
      Get.back();
    }
  }

  void getBackEPassword() {
    if (newPass.text.isNotEmpty || oldPass.text.isNotEmpty || cNewPass.text.isNotEmpty) {
      Get.dialog(CustomAlertDialog(
          onPressedno: () {
            Get.back();
          },
          onPressedyes: () async {
            Get.back();
            discardEPass();
            Get.back();
          },
          backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
          title: "Are You Sure Want to Quit?\nyour changes will not be saved",
          fontColor: Color.fromARGB(204, 255, 255, 255),
          fontSize: 20,
          iconColor: Colors.white));
    } else {
      Get.back();
    }
  }

  void buttonPermissionEPass() {
    if (newPass.text.isNotEmpty && cNewPass.text.isNotEmpty && oldPass.text.isNotEmpty) {
      buttonPermEPass = true;
    } else {
      buttonPermEPass = false;
    }
  }

  void buttonPermissionEP() {
    if (username.text.isNotEmpty ||
        name.text.isNotEmpty ||
        weight.text.isNotEmpty ||
        height.text.isNotEmpty ||
        selectedValue.toLowerCase() != user.gender) {
      buttonPermEP = true;
    } else {
      buttonPermEP = false;
    }
    buttonPermEPass = false;
  }

  void discardEPass() {
    cNewPass.text = "";
    newPass.text = "";
    oldPass.text = "";
  }

  void discardEP() {
    username.text = "";
    name.text = "";
    height.text = "";
    weight.text = "";
    selectedValue = items[items.indexWhere((element) => element.toLowerCase() == user.gender)];
  }

  @override
  void onInit() {
    user = Get.arguments ?? user;
    selectedValue = items[items.indexWhere((element) => element.toLowerCase() == user.gender)];
    super.onInit();
  }
}
