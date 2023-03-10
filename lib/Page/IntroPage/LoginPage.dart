import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/AuthetificationController.dart';
import 'package:pain/widget/BasicLoader.dart';
import 'package:pain/widget/ButtonCustomMain.dart';
import 'package:pain/widget/TextFieldCustom.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginPage extends GetView<AuthentificationController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final fontsize = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
        child: GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.075),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 27,
              ),
              Image.asset(
                "asset/Image/Group_35.png",
                width: 65,
              ),
              SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontFamily: 'PoppinsBoldSemi',
                      fontSize: 32,
                      color: Color.fromRGBO(255, 255, 255, 0.8)),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Sign in to your Account",
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontFamily: 'RubikLight',
                    fontSize: 27,
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldCustom(
                    onChanged: (text) {},
                    TextController: controller.usernameLogin.value,
                    inputType: TextInputType.text,
                    obscureText: false,
                    prefixColor: Color.fromRGBO(10, 12, 13, 1),
                    TextColor: Color.fromRGBO(10, 12, 13, 1),
                    fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                    HintTextColor: Color.fromRGBO(10, 12, 13, 0.5),
                    hintText: "Insert Your Username",
                    ImageSource: "asset/Icon/profileIconLogin.png",
                    prefixIconScale: 10,
                    widget: Text(""),
                    widthTextField: 2,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Obx(() => TextFieldCustom(
                        onChanged: (text) {},
                        TextController: controller.passwordLogin.value,
                        inputType: TextInputType.text,
                        hintText: controller.hint.toString(),
                        ImageSource: "asset/Icon/passIconLogin.png",
                        prefixIconScale: 11,
                        widthTextField: 2,
                        obscureText: controller.passVisble == false ? true : false,
                        HintTextColor: Color.fromRGBO(10, 12, 13, 0.5),
                        prefixColor: Color.fromRGBO(10, 12, 13, 1),
                        TextColor: Color.fromRGBO(10, 12, 13, 1),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                        widget: Container(
                          padding: EdgeInsets.only(right: 8),
                          child: IconButton(
                              icon: controller.passVisble == false
                                  ? Image.asset(
                                      "asset/Icon/EyeVisibleIconBlack.png",
                                      width: 28,
                                    )
                                  : Image.asset(
                                      "asset/Icon/EyeInvisibleIconBlack.png",
                                      width: 28,
                                    ),
                              onPressed: () {
                                if (controller.passVisble == false) {
                                  controller.passVisble = true;
                                } else {
                                  controller.passVisble = false;
                                }
                                print(controller.passVisble);
                              }),
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Forgot your Password?",
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontFamily: 'PoppinsLight',
                        fontSize: 12,
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ButtonCustomMain(
                      alignText: Alignment.center,
                        borderRadius: 30,
                        permission: true,
                        onPressed: () async {
                          await controller.login();
                        },
                        colorText: Colors.white,
                        title: "Login",
                        primary: Color.fromRGBO(170, 5, 27, 1)),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                            text: "Don’t have an Account? ",
                            style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              fontSize: 18,
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  fontFamily: "PoppinsBoldSemi",
                                  fontSize: 18,
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed("/regist");
                                  },
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
