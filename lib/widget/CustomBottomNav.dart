import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomBottomNav extends StatelessWidget {
  final int index;
  final void Function(int) onTap;

  CustomBottomNav({Key? key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.075,
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
              activeIcon: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 32,
                  )),
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 36,
              ),
              label: "Dashboard",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              activeIcon: Container(
                  padding: EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    color: Colors.black,
                    size: 32,
                  )),
              icon: const Icon(
                Icons.fitness_center_rounded,
                color: Colors.white,
                size: 36,
              ),
              label: "Challange",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              activeIcon: Container(
                  padding: EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.place_rounded,
                    color: Colors.black,
                    size: 32,
                  )),
              icon: const Icon(
                Icons.place_rounded,
                color: Colors.white,
                size: 36,
              ),
              label: "Places",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              activeIcon:
                  Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.photo_library_rounded,
                    color: Colors.black,
                    size: 32,
                  )),
              icon: const Icon(
                Icons.photo_library_rounded,
                color: Colors.white,
                size: 36,
              ),
              label: "a",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              activeIcon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 32,
                  )),
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 36,
              ),
              label: "Profile",
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
