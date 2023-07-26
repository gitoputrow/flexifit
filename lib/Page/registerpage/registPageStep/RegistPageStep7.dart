import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/CustomRadioButton.dart';
import 'package:pain/widget/TextFieldCustom.dart';

class RegistPageStep7 extends GetView<AuthentificationController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.075),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("asset/BackgroundImage/bgIntroScreen7.png"),
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
                "Create Account",
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
                "Set your Username & Password\nso you can keep your Account ",
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
            height: MediaQuery.of(context).size.height < 800 ? 40 : 50,
          ),
            TextFieldCustom(
              onChanged: (text) {
                controller.continueRegistFunc();
              },
              TextController: controller.username.value,
              inputType: TextInputType.text,
              hintText: "Insert your username",
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
            Obx(
              () => TextFieldCustom(
              onChanged: (text) {
                controller.continueRegistFunc();
              },
              TextController: controller.password.value,
              inputType: TextInputType.text,
              hintText: "Set your password",
              ImageSource: "asset/Icon/passIcon.png",
              widget: Container(
                padding: EdgeInsets.only(right: 8),
                child: IconButton(
                    icon: controller.passResistVisble == false
                        ? Image.asset("asset/Icon/EyeInvsibleIcon.png"
                            ,
                            width: 28,
                          )
                        : Image.asset(
                            "asset/Icon/EyeVisibleIcon.png",
                            width: 28,
                          ),
                    onPressed: () {
                      if (controller.passResistVisble == false) {
                        controller.passResistVisble = true;
                      } else {
                        controller.passResistVisble = false;
                      }
                      print(controller.passVisble);
                    }),
              ),
              prefixIconScale: 11,
              obscureText: controller.passResistVisble == false ? true : false,
              fillColor: Color.fromRGBO(10, 12, 13, 0.8),
              prefixColor: Colors.white,
              HintTextColor: Colors.white30,
              TextColor: Colors.white,
              widthTextField: 0,
            ),
            ),
            SizedBox(
              height: 26,
            ),
            Obx(
              () => TextFieldCustom(
              onChanged: (text) {
                controller.continueRegistFunc();
              },
              TextController: controller.cpassword.value,
              inputType: TextInputType.text,
              hintText: "Confirm your password",
              ImageSource: "asset/Icon/passIcon.png",
              widget: Container(
                padding: EdgeInsets.only(right: 8),
                child: IconButton(
                    icon: controller.cpassResistVisble == false
                        ? Image.asset("asset/Icon/EyeInvsibleIcon.png"
                            ,
                            width: 28,
                          )
                        : Image.asset(
                            "asset/Icon/EyeVisibleIcon.png",
                            width: 28,
                          ),
                    onPressed: () {
                      if (controller.cpassResistVisble == false) {
                        controller.cpassResistVisble = true;
                      } else {
                        controller.cpassResistVisble = false;
                      }
                      print(controller.passVisble);
                    }),
              ),
              prefixIconScale: 11,
              obscureText: controller.cpassResistVisble == false ? true : false,
              fillColor: Color.fromRGBO(10, 12, 13, 0.8),
              prefixColor: Colors.white,
              HintTextColor: Colors.white30,
              TextColor: Colors.white,
              widthTextField: 0,
            ),
            )
          ],
        ),
      ),
    );
  }
}
