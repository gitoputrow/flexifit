import 'package:flutter/material.dart';
import 'package:pain/theme/colors.dart';

class CustomRadioButton extends StatelessWidget {
  void Function()? onPressed;
  String title;
  double? fontSize;
  double? subFontSize;
  bool isSelected;
  String? subTextTitle;
  Color? colorButton;
  Color? colorText;
  Color? colorSubText;

  CustomRadioButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.isSelected = false,
      this.fontSize,
      this.colorSubText,
      this.subFontSize,
      this.subTextTitle,
      this.colorText,
      this.colorButton});

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
                    fontSize: fontSize ?? 22,
                    color: () {
                      if (colorText != null) {
                        return colorText;
                      } else {
                        if (isSelected) {
                          return infoColor;
                        } else {
                          return secondaryTextColor;
                        }
                      }
                    }()),
              ),
              if(subTextTitle != null)...[
                SizedBox(
                  height: 6,
                ),
                Text(
                  subTextTitle!,
                  textScaleFactor: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'RubikRegular',
                      fontSize: 16,
                      color: (){
                        if (colorSubText != null){
                          return colorSubText;
                        }else{
                          if (isSelected){
                            return infoColor;
                          }else{
                            return secondaryTextColor;
                          }
                        }
                      }()),
                )
              ]
            ],
          )),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height < 800 ? 16 : 20),side: isSelected ? BorderSide.none : BorderSide(color: secondaryColor,width: 1.5)), backgroundColor: () {
            if (colorButton != null) {
              return colorButton;
            } else {
              if (isSelected) {
                return secondaryTextColor;
              } else {
                return infoColor;
              }
            }
          }(),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height < 800 ? 18 : 24)),
    );
  }
}
