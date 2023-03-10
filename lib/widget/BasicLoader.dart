import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class BasicLoader extends StatelessWidget {
  const BasicLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlowingProgressIndicator(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "asset/Image/workoutIcon.png",
          scale: 3,
        ),
        Text(
          "LOADING",
          style: TextStyle(
              fontFamily: 'RubikMedium',
              decoration: TextDecoration.none,
              fontSize: 18,
              color: Colors.white),
        )
      ],
    ));
  }
}
