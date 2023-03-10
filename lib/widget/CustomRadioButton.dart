import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  void Function()? onPressed;
  String title;
  bool condition;
  double fontSize;
  Text? subText;
  Color selectedText;
  Color unSelectedText;
  Color selectedBut;
  Color unSelectedBut;

  CustomRadioButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.condition,
    required this.fontSize,
    required this.subText,
    required this.selectedBut,
    required this.selectedText,
    required this.unSelectedBut,
    required this.unSelectedText
  });

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
                    color: condition
                        ? unSelectedText
                        : selectedText),
              ),
              SizedBox(
                height: subText == null ? 0 : 6,
              ),
              subText == null ? Container() : subText!
            ],
          )),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: condition ? unSelectedBut : selectedBut,
          padding: EdgeInsets.symmetric(vertical: 24)),
    );
  }
}
