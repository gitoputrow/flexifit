import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  String hintText;
  String ImageSource;
  Widget? widget;
  double prefixIconScale;
  bool obscureText;
  Color fillColor;
  Color prefixColor;
  Color TextColor;
  Color HintTextColor;
  double widthTextField;
  TextInputType inputType;
  TextEditingController TextController;
  void Function(String)? onChanged;

  TextFieldCustom(
      {Key? key,
      required this.hintText,
      required this.ImageSource,
      required this.widget,
      required this.prefixIconScale,
      required this.obscureText,
      required this.fillColor,
      required this.prefixColor,
      required this.HintTextColor,
      required this.TextColor,
      required this.widthTextField,
      required this.inputType,
      required this.TextController,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      controller: TextController,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 28, horizontal: 24),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'RubikMedium',
          color: HintTextColor,
          fontSize: 19,
        ),
        prefixIcon: Container(
          padding: EdgeInsets.only(left: 18, right: 10),
          child: Image.asset(
            ImageSource,
            scale: prefixIconScale,
          ),
        ),
        prefixIconColor: prefixColor,
        suffixIcon: widget == null ? null : widget,
        fillColor: fillColor,
        filled: true,
        iconColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.9), width: widthTextField),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.9), width: widthTextField),
        ),
      ),
      style: TextStyle(
        color: TextColor,
        fontSize: 18,
      ),
    );
  }
}
//Color.fromRGBO(10, 12, 13, 1),
//Color.fromRGBO(255, 255, 255, 0.4),