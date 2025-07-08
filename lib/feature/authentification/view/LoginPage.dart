import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/controller/AuthetificationController.dart';
import 'package:pain/feature/authentification/controller/LoginController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/BasicLoader.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/TextFieldCustom.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.075),
          child: FormBuilder(
            key: controller.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                        "asset/Icon/app_logo.svg",
                        width: 96,
                      ),
                const SizedBox(
                  height: 18,
                ),
                const Align(
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
                const SizedBox(
                  height: 8,
                ),
                const Align(
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
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFieldCustom(
                      name: "username",
                      keyboardType: TextInputType.text,
                      hintText: "Insert Your Username",
                      imageSource: "asset/Icon/profileIconLogin.png",
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    TextFieldCustom(
                      name: "pass",
                      keyboardType: TextInputType.text,
                      isObscureText: true,
                      hintText: "Insert Your Password",
                      imageSource: "asset/Icon/passIconLogin.png",
                      prefixIconScale: 11,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed("/forgotpass"),
                      child: const Align(
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
                        borderRadius: 30,
                        onPressed: () async {
                          await controller.login();
                        },
                        title: "Login",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomTextButton(
                          title: "Don’t have an Account? ",
                          buttonTitle: "Sign Up",
                          onTap: () {
                            Get.toNamed("/regist");
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
