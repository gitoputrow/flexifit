import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomBottomNav extends StatelessWidget {
  final int index;
  final void Function(int) onTap;

  CustomBottomNav({Key? key, required this.index,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25, top: 5),
      child: BottomNavigationBar(
        elevation: 0,
        onTap: onTap,
        currentIndex: index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        items: [
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                  "asset/Image/HomeActiveIcon.png",
                  width: 40,
                  height: 40,
                ),
              icon: Image.asset(
                  "asset/Image/HomeIcon.png",
                  width: 40,
                  height: 40,
                ),
              label: "a",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                  "asset/Image/workoutIconActive.png",
                  width: 40,
                  height: 40,
                ),
              icon:Image.asset(
                  "asset/Image/workoutIcon.png",
                  width: 40,
                  height: 40,
                ),
              label: "a",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.discovery,color: Colors.white,size: 40),
              icon:Icon(IconlyLight.discovery,color: Colors.white,size: 39,),
              label: "a",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              activeIcon: Image.asset(
                  "asset/Image/profilepageIconActive.png",
                  width: 40,
                  height: 40,
                ),
              icon: Image.asset(
                  "asset/Image/profilepageIcon.png",
                  width: 40,
                  height: 40,
                ),
              label: "a",
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
