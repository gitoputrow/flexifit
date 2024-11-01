import 'package:flutter/gestures.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:pain/theme/colors.dart';

class ButtonCustomMain extends StatelessWidget {
  void Function()? onPressed;
  String title;
  Color? primary;
  Color? colorText;
  Color? primaryFalse;
  Color? colorTextFalse;
  double? borderRadius;
  bool permission;
  AlignmentGeometry? alignText;
  BorderSide? borderSide;

  ButtonCustomMain({
    Key? key,
    this.primaryFalse,
    this.colorTextFalse,
    required this.onPressed,
    required this.title,
    this.primary,
    this.colorText,
    this.borderRadius,
    this.borderSide,
    this.alignText = Alignment.center,
    this.permission = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Container(
            padding:
                EdgeInsets.only(left: alignText == Alignment.center ? 0 : 25),
            alignment: alignText ?? Alignment.center,
            child: Text(
              title,
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: 19,
                fontFamily: 'RubikMedium',
                color: () {
                  if (!permission) {
                    return colorTextFalse ?? disabledTextColor;
                  } else {
                    return colorText ?? primaryTextColor;
                  }
                }(),
              ),
            )),
        style: ElevatedButton.styleFrom(
            splashFactory: permission == true ? null : NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 28),side: borderSide ?? BorderSide.none),
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height < 800 ? 12 : 16),
            backgroundColor: () {
              if (permission) {
                return primary ?? primaryColor;
              } else {
                return primaryFalse ?? buttonDiabledColor;
              }
            }(),
            foregroundColor: Color.fromRGBO(0, 0, 0, 1.0)),
      );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.title,
      required this.buttonTitle,
      this.titleColor,
      this.buttonTitleColor,
      required this.onTap});

  final String title;
  final Color? titleColor;
  final String buttonTitle;
  final Color? buttonTitleColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: title,
          style: TextStyle(
            fontFamily: "PoppinsRegular",
            fontSize: 18,
            color: titleColor ?? tertiaryTextColor,
          ),
          children: <TextSpan>[
            TextSpan(
              text: buttonTitle,
              style: TextStyle(
                fontFamily: "PoppinsBoldSemi",
                fontSize: 18,
                color: buttonTitleColor ?? secondaryTextColor,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            )
          ]),
    );
  }
}
