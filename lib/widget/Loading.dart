import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("asset/Image/loadingscreen.png",width: 112,height: 54,),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 76),
                child: LinearProgressIndicator(
                  color: Color.fromRGBO(205, 5, 27, 1),
                  backgroundColor: Colors.white,
                  semanticsLabel: 'Linear progress indicator',
                ),
        )
      ],
    );
  }
}
