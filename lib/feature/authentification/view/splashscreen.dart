import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/view/HomeScreen.dart';
import 'package:pain/feature/MainPage.dart';
import 'package:pain/StorageProvider.dart';
// import 'package:pain/ValidationPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    Timer(Duration(seconds: 3), () async {
      final user = await StorageProvider.getUserToken();
      if (user != null) {
        Get.offNamed("/dashboard",arguments: 0);
      } else {
        Get.off(HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 12, 13, 1),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: SvgPicture.asset(
            "asset/Icon/app_logo.svg",
          ),
        ),
      ),
    );
  }
}
