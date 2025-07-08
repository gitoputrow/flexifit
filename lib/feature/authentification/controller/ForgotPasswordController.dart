import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../theme/colors.dart';
import '../../../widget/BasicLoader.dart';
import '../../../widget/ToastMessageCustom.dart';

class ForgotPasswordController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormBuilderState> form = GlobalKey();

  Future sendForgotPassword() async {
    if (!form.currentState!.saveAndValidate()) {
      return;
    }
    Get.dialog(BasicLoader());
    FocusManager.instance.primaryFocus?.unfocus();
    final data = await firestore
        .collection("usersData")
        .where('username', isEqualTo: form.currentState!.value['username'])
        .get();
    if (data.docs.isEmpty) {
      Get.back();
      ToastMessageCustom.ToastMessage("Username Not Found", primaryDarkColor,
          textColor: Colors.white);
    } else {
      try {
        await firebaseAuth.sendPasswordResetEmail(
          email: data.docs.first.data()['email'],
        );
        Get.back();
        ToastMessageCustom.ToastMessage("Reset Password Sent to ${data.docs.first.data()['email']}", primaryTextColor,
              textColor: Colors.black);
      } on FirebaseAuthException catch (e) {
        log("catch firebase : " + e.code.toString());
        Get.back();
          ToastMessageCustom.ToastMessage(e.code, primaryDarkColor,
              textColor: Colors.white);
      } catch (e) {
        Get.back();
        log("catch : " + e.toString());
      }
    }
    
  }
}
