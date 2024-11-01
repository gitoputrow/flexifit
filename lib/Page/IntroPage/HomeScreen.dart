import 'dart:developer';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:pain/Introduction/GenderSelected.dart';
import 'package:flutter/gestures.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ButtonCustomMain.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: tertiaryColor,
        body: SizedBox(
          height: context.height,
          width: context.width,
          child: Stack(
            children: [
              SizedBox(
                height: context.height,
                width: context.width,
                child: Opacity(
                  opacity: 0.7,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        const Color.fromARGB(255, 124, 124, 124),
                        BlendMode.saturation),
                    child: Image.asset(
                      "asset/BackgroundImage/bgHomeScreen.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.075),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 27),
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "asset/Image/Group_35.png",
                        width: 65,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Get in Shape",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontFamily: 'PoppinsBoldSemi',
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      "with several workout",
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontFamily: 'RubikLight',
                        fontSize: 23,
                      ),
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    ButtonCustomMain(
                      borderRadius: 30,
                      colorText: Color.fromARGB(255, 255, 255, 255),
                      onPressed: () {
                        Get.toNamed("/regist");
                      },
                      title: "Getting Started",
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    ButtonCustomMain(
                        borderRadius: 30,
                        onPressed: () {
                          Get.toNamed("/login");
                        },
                        title: "Sign in",
                        borderSide: BorderSide(color: primaryColor,width: 1.5),
                        // colorText: Colors.white,
                        primary: infoColor),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
