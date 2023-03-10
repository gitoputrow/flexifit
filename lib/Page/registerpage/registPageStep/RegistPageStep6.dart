import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/CustomRadioButton.dart';
import 'package:pain/widget/TextFieldCustom.dart';

class RegistPageStep6 extends GetView<AuthentificationController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.075),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/BackgroundImage/bgIntroScreen6.png"),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 115,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Profile Details",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  fontFamily: 'PoppinsBoldSemi',
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Enter your parameters to get a\npersonalized plan",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.7),
                  fontFamily: 'PoppinsMedium',
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextFieldCustom(
              onChanged: (text) {
                controller.continueRegistFunc();
              },
              TextController: controller.name.value,
              inputType: TextInputType.name,
              hintText: "Insert your name",
              ImageSource: "asset/Icon/profileIcon.png",
              widget: null,
              prefixIconScale: 11,
              obscureText: false,
              fillColor: Color.fromRGBO(10, 12, 13, 0.8),
              prefixColor: Colors.white,
              HintTextColor: Colors.white30,
              TextColor: Colors.white,
              widthTextField: 0,
            ),
            SizedBox(
              height: 26,
            ),
            TextFieldCustom(
              onChanged: (text) {
                controller.continueRegistFunc();
              },
              TextController: controller.age.value,
              inputType: TextInputType.number,
              hintText: "Insert your Age",
              ImageSource: "asset/Icon/ageIcon.png",
              widget: null,
              prefixIconScale: 11,
              obscureText: false,
              fillColor: Color.fromRGBO(10, 12, 13, 0.8),
              prefixColor: Colors.white,
              HintTextColor: Colors.white30,
              TextColor: Colors.white,
              widthTextField: 0,
            ),
            SizedBox(
              height: 26,
            ),
            TextFieldCustom(
              onChanged: (text) {
                controller.continueRegistFunc();
              },
              TextController: controller.weight.value,
              inputType: TextInputType.number,
              hintText: "Current Weight",
              ImageSource: "asset/Icon/weightIcon.png",
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: Text(
                      "Kg",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
              prefixIconScale: 11,
              obscureText: false,
              fillColor: Color.fromRGBO(10, 12, 13, 0.8),
              prefixColor: Colors.white,
              HintTextColor: Colors.white30,
              TextColor: Colors.white,
              widthTextField: 0,
            ),
            SizedBox(
              height: 26,
            ),
            // TextFieldCustom(
            //   inputType: TextInputType.number,
            //   hintText: "Target Weight",
            //   ImageSource: "asset/Icon/TargetIcon.png",
            //   widget: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         padding: EdgeInsets.only(right: width*0.05),
            //         child: Text(
            //           "Kg",
            //           style: TextStyle(
            //             color: Color.fromRGBO(255, 255, 255, 0.5),
            //             fontSize: 19,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   prefixIconScale: 11,
            //   obscureText: false,
            //   fillColor: Color.fromRGBO(10, 12, 13, 0.8),
            //   prefixColor: Colors.white,
            //   HintTextColor: Colors.white30,
            //   TextColor: Colors.white,
            //   widthTextField: 0,
            // ),
            // SizedBox(
            //   height: 26,
            // ),
            TextFieldCustom(
              onChanged: (text) {
                controller.continueRegistFunc();
                print("object");
              },
              TextController: controller.height.value,
              inputType: TextInputType.number,
              hintText: "Current Height",
              ImageSource: "asset/Icon/heightIcon.png",
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: Text(
                      "Cm",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        fontSize: 19,
                      ),
                    ),
                  ),
                ],
              ),
              prefixIconScale: 11,
              obscureText: false,
              fillColor: Color.fromRGBO(10, 12, 13, 0.8),
              prefixColor: Colors.white,
              HintTextColor: Colors.white30,
              TextColor: Colors.white,
              widthTextField: 0,
            ),
          ],
        ),
      ),
    );
  }
}
