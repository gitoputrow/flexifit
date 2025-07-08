import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/utils/extensions.dart';

class TextFieldCustom extends StatelessWidget {
  String? hintText;
  String name;
  String? label;
  TextStyle? labelStyle;
  String? imageSource;
  Widget? suffixIcon;
  double? prefixIconScale;
  bool isObscureText;
  Color? fillColor;
  Color? prefixColor;
  bool readOnly;
  Color? borderColorEnabled;
  Color? borderColorFocused;
  Color? textColor;
  Color? hintTextColor;
  double? widthTextField;
  bool isRequired;
  EdgeInsetsGeometry? contentPadding;
  TextInputType? keyboardType;
  TextEditingController? textController;
  int? maxLines;
  int? minLines;
  bool isUsername;

  void Function(String?)? onChanged;

  TextFieldCustom(
      {Key? key,
      required this.name,
      this.hintText,
      this.isUsername = false,
      this.imageSource,
      this.label,
      this.readOnly = false,
      this.suffixIcon,
      this.contentPadding,
      this.prefixIconScale,
      this.maxLines = 1,
      this.minLines,
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
      this.labelStyle,
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null) ...[
              Text.rich(TextSpan(
                  children: isRequired
                      ? [
                          TextSpan(
                              text: "*",
                              style: TextStyle(
                                  fontFamily: "PoppinsBoldSemi",
                                  color: primaryColor,
                                  fontSize: 16))
                        ]
                      : null,
                  text: label,
                  style: labelStyle ??
                      TextStyle(
                          fontFamily: "PoppinsBoldSemi",
                          color: Colors.white,
                          fontSize: 16))),
              SizedBox(
                height: 12,
              ),
            ],
            FormBuilderTextField(
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
                  return 'Email is Invalid';
                }

                if (isObscureText && val != null && val.length < 6) {
                    return 'Password must be at least 6 characters';
                }

                if (isUsername && val != null && val.contains(" ")) {
                  return 'Username Cannot Contain Space';
                }

                bool isNumberInput = keyboardType == TextInputType.number;
                if (isNumberInput) {
                  if (val != null && num.tryParse(val) == null) {
                    return 'Isian harus berupa angka.${val.contains(",") ? " Hindari penggunaan (,) gunakan (.)" : ""}';
                  }
                }

                return null;
              },
              maxLines: maxLines,
              minLines: minLines,
              readOnly: readOnly,
              decoration: InputDecoration(
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(vertical: 28, horizontal: 24),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontFamily: 'RubikMedium',
                    color: hintTextColor ?? hintTextColor,
                    fontSize: 18,
                  ),
                  prefixIcon: imageSource == null
                      ? null
                      : Container(
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
                        size: 28,
                        color: prefixColor,
                      ),
                    );
                  }(),
                  fillColor: fillColor ?? filledColor,
                  filled: true,
                  isDense: true,
                  iconColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                        color:
                            borderColorEnabled ?? Color.fromRGBO(0, 0, 0, 0.9),
                        width: widthTextField ?? 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                        color:
                            borderColorFocused ?? Color.fromRGBO(0, 0, 0, 0.9),
                        width: widthTextField ?? 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(color: primaryDarkColor, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(color: primaryDarkColor, width: 2),
                  ),
                  errorStyle: TextStyle(color: primaryColor, fontSize: 14)),
              style: TextStyle(
                color: textColor ?? tertiaryColor,
                fontSize: 18,
              ),
            ),
          ],
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
