import 'dart:developer';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// import 'package:pain/Introduction/GenderSelected.dart';
import 'package:flutter/gestures.dart';
import 'package:pain/widget/ButtonCustomMain.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.075),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("asset/BackgroundImage/bgHomeScreen.png"),
                  fit: BoxFit.cover)),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 27,
                  ),
                  Image.asset(
                    "asset/Image/Group_35.png",
                    width: 65,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Get in Shape",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontFamily: 'PoppinsBoldSemi',
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    "with several workout",
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontFamily: 'RubikLight',
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ButtonCustomMain(
                        alignText: Alignment.center,
                        borderRadius: 30,
                        permission: true,
                          onPressed: () {
                            Get.toNamed("/regist");
                          },
                          colorText: Colors.white,
                          title: "Getting Started",
                          primary: Color.fromRGBO(170, 5, 27, 1)),
                      SizedBox(
                        height: 23,
                      ),
                      ButtonCustomMain(
                        alignText: Alignment.center,
                        borderRadius: 30,
                        permission: true,
                          onPressed: () {
                            Get.toNamed("/login");
                          },
                          colorText: Colors.white,
                          title: "Sign in",
                          primary: Color.fromRGBO(10, 12, 13, 0.8)),
                      SizedBox(
                        height: 65.5,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
