import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ButtonCustomMain extends StatelessWidget {
  void Function()? onPressed;
  String title;
  Color primary;
  Color colorText;
  Color? primaryFalse;
  Color? colorTextFalse;
  double borderRadius;
  bool permission;
  AlignmentGeometry alignText;

  ButtonCustomMain({
    Key? key,
    this.primaryFalse,
    this.colorTextFalse,
    required this.onPressed,
    required this.title,
    required this.primary,
    required this.colorText,
    required this.borderRadius,
    required this.alignText,
    required this.permission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.only(left: alignText == Alignment.center ? 0 : 25),
          alignment: alignText,
          child: Text(
            title,
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 19,
                fontFamily: 'RubikMedium',
                color: permission == true ? colorText : colorTextFalse),
          ),
        ),
        style: ElevatedButton.styleFrom(
            splashFactory: permission == true ? null : NoSplash.splashFactory,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height < 800 ? 17 : 23),
            backgroundColor: permission == true ? primary : primaryFalse,
            foregroundColor: Color.fromRGBO(0, 0, 0, 1.0)),
      ),
    );
  }
}
