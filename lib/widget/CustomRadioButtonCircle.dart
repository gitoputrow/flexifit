import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomRadioButtonCircle extends StatelessWidget {
  String title;
  Color colorText;
  Color colorButton;
  void Function()? onPressed;

  CustomRadioButtonCircle({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.colorButton,
    required this.colorText
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          textScaleFactor: 1,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'RubikSemiBold',
            fontSize: 20,
            color: colorText,
          ),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)), backgroundColor: colorButton,
            padding: EdgeInsets.symmetric(horizontal: 28,vertical: 20)),
      );
  }
}
