import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  void Function()? onPressed;
  String title;
  double fontSize;
  Text? subText;
  Color colorButton;
  Color colorText;

  CustomRadioButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.fontSize,
      required this.subText,
      required this.colorText,
      required this.colorButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
          padding: EdgeInsets.only(left: 28),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'RubikSemiBold',
                    fontSize: fontSize,
                    color: colorText),
              ),
              SizedBox(
                height: subText == null ? 0 : 6,
              ),
              subText == null ? SizedBox() : subText!
            ],
          )),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: colorButton,
          padding: EdgeInsets.symmetric(vertical: 24)),
    );
  }
}
