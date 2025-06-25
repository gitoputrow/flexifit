import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ShimmerLoading.dart';

class HeaderPageWidget extends StatelessWidget {
  const HeaderPageWidget(
      {super.key,
      this.isLoading = false,
      required this.text,
      this.textStyle,
      this.result = false,
      this.padding});

  final bool isLoading;

  final String text;

  final TextStyle? textStyle;

  final EdgeInsetsGeometry? padding;

  final bool result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(result: result),
            child: Image.asset(
              "asset/Image/backwo.png",
              width: 34,
              height: 34,
            ),
          ),
          ShimmerLoading(
            isLoading: isLoading,
            child: Flexible(
              child: Text(
                text,
                style: textStyle ??
                    const TextStyle(
                        fontSize: 24,
                        fontFamily: 'PoppinsBoldSemi',
                        color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            "asset/Image/backwo.png",
            width: 34,
            height: 34,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
