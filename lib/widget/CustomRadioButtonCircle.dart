import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomRadioButtonCircle extends StatelessWidget {
  String title;
  Color selectedText;
  Color unSelectedText;
  Color selectedBut;
  Color unSelectedBut;
  void Function()? onPressed;
  bool condition;

   CustomRadioButtonCircle({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.condition,
    required this.selectedBut,
    required this.selectedText,
    required this.unSelectedBut,
    required this.unSelectedText
  }); 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'RubikSemiBold',
              fontSize: 20,
              color: condition ? unSelectedText : selectedText,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            primary: condition ? unSelectedBut : selectedBut,
            padding: EdgeInsets.symmetric(vertical: 21)),
      ),
    );
  }
}
