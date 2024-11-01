import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/theme/colors.dart';

class ToastMessageCustom{
  static void ToastMessage(String text,Color color,{Color? textColor}) {
    Get.snackbar(
      "",
      "",
      titleText: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 15,
          ),
          Image.asset(
            "asset/Icon/warning.png",
            width: 30,
            height: 30,
            color: textColor ?? infoColor,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              text,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: "RubikMedium",
                color: textColor ?? infoColor,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      colorText: Color.fromARGB(255, 255, 255, 255),
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: Get.width/1.36,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: EdgeInsets.only(top: 25),
      snackStyle: SnackStyle.FLOATING,
    );
  }
}