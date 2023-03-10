import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  Color backgroundColor;
  String title;
  double fontSize;
  Color fontColor;
  Color iconColor;
  void Function()? onPressedno;
  void Function()? onPressedyes;

  CustomAlertDialog(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      required this.fontColor,
      required this.fontSize,
      required this.iconColor,
      required this.onPressedno,
      required this.onPressedyes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      content: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "RubikRegular", fontSize: fontSize, color: fontColor),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "asset/Image/workoutIcon.png",
              color: iconColor,
              scale: 3,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 14),
                        child: ElevatedButton(
                          onPressed: onPressedyes,
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'RubikMedium', color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              primary: Color.fromRGBO(205, 5, 27, 0.8),
                              onPrimary: Color.fromRGBO(0, 0, 0, 1.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 14),
                        child: ElevatedButton(
                          onPressed: onPressedno,
                          child: Text(
                            "No",
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'RubikMedium', color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              primary: Colors.white,
                              onPrimary: Color.fromRGBO(0, 0, 0, 1.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
