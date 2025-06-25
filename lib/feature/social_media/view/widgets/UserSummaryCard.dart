import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pain/feature/authentification/models/UserData.dart';

import '../../../../theme/colors.dart';

class UserSummaryCard extends StatelessWidget {
  const UserSummaryCard({super.key, this.data});

  final UserData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Weight (kg)",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'PoppinsBoldSemi',
                    color: Colors.white),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "${data?.weight}",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'PoppinsBoldSemi',
                    color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Post",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'PoppinsBoldSemi',
                    color: Colors.white),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "${data?.post}",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'PoppinsBoldSemi',
                    color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Height (cm)",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'PoppinsBoldSemi',
                    color: Colors.white),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "${data?.height}",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'PoppinsBoldSemi',
                    color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
