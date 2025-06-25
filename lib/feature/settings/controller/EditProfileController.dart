import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../StorageProvider.dart';
import '../../authentification/models/UserData.dart';
import '../../../model/UserPhoto.dart';
import '../../authentification/view/HomeScreen.dart';
import '../../../theme/colors.dart';
import '../../../widget/BasicLoader.dart';
import '../../../widget/CustomAlertDialog.dart';
import '../../../widget/ToastMessageCustom.dart';

class EditProfileController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Rx<UserData?> _user = (null as UserData?).obs;
  UserData? get user => _user.value;
  set user(UserData? user) => _user.value = user;

  RxList<UserPhoto> _userPhoto = <UserPhoto>[].obs;
  List<UserPhoto> get userPhoto => _userPhoto.value;
  set userPhoto(List<UserPhoto> userPhoto) => _userPhoto.value = userPhoto;

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

  Rx<File?> _imageSource = (null as File?).obs;
  File? get imageSource => _imageSource.value;
  set imageSource(File? imageSource) => _imageSource.value = imageSource;

  Rx<String> _imagepath = "".obs;
  String get imagepath => _imagepath.value;
  set imagepath(String imagepath) => _imagepath.value = imagepath;

  List<String> items = [
    "Male",
    "Female",
  ];

  Rx<String> _selectedValue = "".obs;
  String get selectedValue => _selectedValue.value;
  set selectedValue(String selectedValue) =>
      _selectedValue.value = selectedValue;

  Rx<bool> _buttonPermEP = false.obs;
  bool get buttonPermEP => _buttonPermEP.value;
  set buttonPermEP(bool buttonPermEP) => _buttonPermEP.value = buttonPermEP;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? imageTemporary = File(image.path);
      imageSource = imageTemporary;
      imagepath = imageTemporary.path;
      buttonPermissionEP();
      Get.back();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future uploadImage() async {
    try {
      final userid = await StorageProvider.getUserToken();
      Get.dialog(BasicLoader());
      await storageRef
          .child(userid!)
          .child("pp$userid")
          .putFile(imageSource!)
          .whenComplete(() async => await storageRef
                  .child(userid)
                  .child("pp$userid")
                  .getDownloadURL()
                  .then((value) async {
                await firestore
                    .collection("usersData")
                    .doc(userid)
                    .update({"photo_profile": value});
              }));
    } catch (e) {}
  }

  Future changeProfile() async {
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          Get.back();
          try {
            Get.dialog(BasicLoader());
            final id = await StorageProvider.getUserToken();
            final data = await firestore
                .collection("usersData")
                .where('username', isEqualTo: username.text)
                .get();
            if (data.docs.isNotEmpty) {
              ToastMessageCustom.ToastMessage(
                  "Username Already Taken", primaryDarkColor,
                  textColor: Colors.white);
            } else {
              await uploadImage();
              user!.username =
                  username.text.isNotEmpty ? username.text : user!.username;
              user!.name = name.text.isNotEmpty ? name.text : user!.name;
              user!.height =
                  height.text.isNotEmpty ? height.text : user!.height;
              user!.weight =
                  weight.text.isNotEmpty ? weight.text : user!.weight;
              user!.gender = selectedValue != user!.gender
                  ? selectedValue.toLowerCase()
                  : user!.gender;
              await firestore.collection("usersData").doc(id).update({
                "username": user!.username,
                "name": user!.name,
                "height": user!.height,
                "weight": user!.weight,
                "gender": user!.gender
              });

              ToastMessageCustom.ToastMessage(
                  "Profile Changed", Color.fromRGBO(10, 12, 13, 0.8));
              Timer(Duration(seconds: 3), () {
                Get.offAllNamed("/dashboard", arguments: 3);
              });
            }
          } catch (e) {}
        },
        backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
        title: "Do you want to Change Your Profile?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
  }

  void buttonPermissionEP() {
    if (username.text.isNotEmpty ||
        name.text.isNotEmpty ||
        weight.text.isNotEmpty ||
        height.text.isNotEmpty ||
        selectedValue.toLowerCase() != user!.gender ||
        imageSource != null) {
      buttonPermEP = true;
    } else {
      buttonPermEP = false;
    }
  }

  void discardEP() {
    Get.dialog(CustomAlertDialog(
        onPressedno: () {
          Get.back();
        },
        onPressedyes: () async {
          Get.back();
          username.text = "";
          name.text = "";
          height.text = "";
          weight.text = "";
          selectedValue = items[items
              .indexWhere((element) => element.toLowerCase() == user!.gender)];
        },
        backgroundColor: Color.fromRGBO(10, 12, 13, 0.8),
        title: "Do you want to Discard Changes?",
        fontColor: Color.fromARGB(204, 255, 255, 255),
        fontSize: 20,
        iconColor: Colors.white));
  }

  @override
  void onInit() async {
    final userid = await StorageProvider.getUserToken();
    try {
      selectedValue = items.first;
      final data = await firestore.collection("usersData").doc(userid).get();
      user = UserData.fromJson(json.decode(json.encode(data.data())));
      selectedValue = items[
          items.indexWhere((element) => element.toLowerCase() == user!.gender)];
    } catch (e) {
      Get.offAll(HomeScreen());
    }

    super.onInit();
  }
}
