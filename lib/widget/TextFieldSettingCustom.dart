import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TextFieldSettingCustom extends StatelessWidget {
  String title;
  String hintText;
  TextEditingController controller;
  bool condition;
  Widget? SuffixIcon;
  void Function(String)? onTextChanged;
  TextInputType keyboardType;

  TextFieldSettingCustom(
      {Key? key,
      required this.title,
      required this.SuffixIcon,
      required this.condition,
      required this.hintText,
      required this.controller,
      required this.onTextChanged,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontFamily: 'RubikLight', fontSize: 17),
        ),
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          obscureText: condition == false ? true : false,
          onChanged: onTextChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15, top: SuffixIcon == null ? 2 : 15),
            hintText: hintText,
            hintStyle: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.5), fontFamily: 'RubikMedium', fontSize: 18),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            suffixIcon: SuffixIcon == null ? null : SuffixIcon,
          ),
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
