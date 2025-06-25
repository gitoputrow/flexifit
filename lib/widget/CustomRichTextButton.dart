import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomRichTextButton extends StatelessWidget {
  const CustomRichTextButton(
      {super.key,
      this.onTap,
      required this.primaryText,
      required this.secondaryText,
      this.primaryTextStyle,
      this.secondaryTextStyle});

  final void Function()? onTap;

  final String primaryText;
  final String secondaryText;
  final TextStyle? primaryTextStyle;
  final TextStyle? secondaryTextStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
            text: primaryText,
            children: [
              TextSpan(
                  text: secondaryText,
                  style: secondaryTextStyle ??
                      const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontFamily: "PoppinsBoldSemi"))
            ],
            style: primaryTextStyle ??
                const TextStyle(
                    color: secondaryTextColor,
                    fontSize: 14,
                    fontFamily: "PoppinsRegular")),
      ),
    );
  }
}
