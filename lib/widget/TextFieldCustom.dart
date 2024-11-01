import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/utils/extensions.dart';

class TextFieldCustom extends StatelessWidget {
  String? hintText;
  String name;
  String? imageSource;
  Widget? suffixIcon;
  double? prefixIconScale;
  bool isObscureText;
  Color? fillColor;
  Color? prefixColor;
  Color? borderColorEnabled;
  Color? borderColorFocused;
  Color? textColor;
  Color? hintTextColor;
  double? widthTextField;
  bool isRequired;
  EdgeInsetsGeometry? contentPadding;
  TextInputType? keyboardType;
  TextEditingController? textController;

  void Function(String?)? onChanged;

  TextFieldCustom(
      {Key? key,
      required this.name,
      this.hintText,
     this.imageSource,
      this.suffixIcon,
      this.contentPadding,
      this.prefixIconScale,
      this.isObscureText = false,
      this.fillColor,
      this.prefixColor,
      this.hintTextColor,
      this.textColor,
      this.borderColorEnabled,
      this.borderColorFocused,
      this.widthTextField,
      this.isRequired = false,
      this.keyboardType,
      this.textController,
      this.onChanged})
      : super(key: key) {
    obscureNotifier.value = isObscureText;
  }

  final ValueNotifier<bool> obscureNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureNotifier,
      builder: (context, value, child) {
        return FormBuilderTextField(
          name: name,
          keyboardType: keyboardType,
          controller: textController,
          obscureText: obscureNotifier.value,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (val) {
            /// Returns error if the form is required but the value is null
            /// or empty
            if (isRequired && (val == null || val.isEmpty)) {
              return 'Fill The Form';
            }

            /// Returns error if the TextInputType.emailAddress and input not valid
            if (keyboardType == TextInputType.emailAddress &&
                val != null &&
                !val.isEmailValid) {
              return 'Surel tidak valid!';
            }

            bool isNumberInput = keyboardType == TextInputType.number;
            if (isNumberInput) {
              
              if (val != null && num.tryParse(val) == null) {
                return 'Isian harus berupa angka.${val.contains(",") ? " Hindari penggunaan (,) gunakan (.)" : ""}';
              }
            }

            return null;
          },
          decoration: InputDecoration(
            contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 28, horizontal: 24),
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'RubikMedium',
              color: hintTextColor ?? hintTextColor,
              fontSize: 19,
            ),
            prefixIcon: imageSource == null ? null : Container(
              padding: EdgeInsets.only(left: 18, right: 10),
              child: Image.asset(
                imageSource!,
                scale: prefixIconScale ?? 10,
              ),
            ),
            prefixIconColor: prefixColor ?? tertiaryColor,
            // suffixIconConstraints: const BoxConstraints(
            //   maxHeight: 32,
            // ),
            suffixIcon: () {
              if (suffixIcon != null) {
                return suffixIcon;
              }

              /// Returns null (no suffix icon) if not obscure field
              if (!isObscureText) {
                return null;
              }

              /// Returns IconButton with icon based on isObscure value
              return IconButton(
                padding: EdgeInsets.only(right: 12),
                onPressed: () {
                  obscureNotifier.value = !value;
                },
                icon: Icon(
                  value ? Icons.visibility_off : Icons.visibility,
                  size: 36,
                  color: prefixColor,
                ),
              );
            }(),
            fillColor: fillColor ?? filledColor,
            filled: true,
            
            iconColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(
                  color: borderColorEnabled ?? Color.fromRGBO(0, 0, 0, 0.9),
                  width: widthTextField ?? 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(
                  color: borderColorFocused ?? Color.fromRGBO(0, 0, 0, 0.9),
                  width: widthTextField ?? 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(
                  color: primaryDarkColor,
                  width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              borderSide: BorderSide(
                  color: primaryDarkColor,
                  width: 2),
            ),
            errorStyle: TextStyle(
              color: primaryColor
            )
          ),
          style: TextStyle(
            color: textColor ?? tertiaryColor,
            fontSize: 18,
          ),
        );
      },
    );
    // TextField(
    //   keyboardType: inputType,
    //   controller: TextController,
    //   onChanged: onChanged,
    //   obscureText: obscureText,
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.symmetric(vertical: 28, horizontal: 24),
    //     hintText: hintText,
    //     hintStyle: TextStyle(
    //       fontFamily: 'RubikMedium',
    //       color: HintTextColor ?? hintTextColor,
    //       fontSize: 19,
    //     ),
    //     prefixIcon: Container(
    //       padding: EdgeInsets.only(left: 18, right: 10),
    //       child: Image.asset(
    //         ImageSource,
    //         scale: prefixIconScale ?? 10,
    //       ),
    //     ),
    //     prefixIconColor: prefixColor ?? tertiaryColor,
    //     suffixIcon: widget,
    //     fillColor: fillColor ?? filledColor,
    //     filled: true,
    //     iconColor: Colors.white,
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(16.0)),
    //       borderSide: BorderSide(
    //           color: Color.fromRGBO(0, 0, 0, 0.9), width: widthTextField ?? 2),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(16.0)),
    //       borderSide: BorderSide(
    //           color: Color.fromRGBO(0, 0, 0, 0.9), width: widthTextField ?? 2),
    //     ),
    //   ),
    //   style: TextStyle(
    //     color: TextColor ?? tertiaryColor,
    //     fontSize: 18,
    //   ),
    // );
  }
}
