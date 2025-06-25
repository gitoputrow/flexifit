import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/CustomRadioButton.dart';
import '../../../../widget/ShimmerLoading.dart';

class GoalsWidget extends StatelessWidget {
  const GoalsWidget({super.key, this.isLoading = false, required this.onChange, required this.goalValue});

  final bool isLoading;

  final void Function(String section, String value) onChange;

  final String goalValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerLoading(
            isLoading: isLoading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                onChange("goal", "build");
              },
              title: "Build Muscle",
              fontSize: 21,
              isSelected: true,
              subTextTitle: 'Build mass & Strength',
              colorSubText: goalValue == "build"
                  ? const Color.fromRGBO(255, 255, 255, 1)
                  : const Color.fromRGBO(255, 255, 255, 0.8),
              colorText: goalValue != "build"
                  ? Colors.white
                  : const Color.fromRGBO(255, 255, 255, 1),
              colorButton: goalValue != "build"
                  ? const Color.fromRGBO(255, 255, 255, 0.3)
                  : primaryColor,
            ),
          ),
        const SizedBox(
          height: 20,
        ),
         ShimmerLoading(
            isLoading: isLoading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
                onPressed: () {
                  onChange("goal", "burn");
                },
                isSelected: true,
                title: "Burn Fat",
                fontSize: 21,
                subTextTitle: 'Burn extra fat & Feel energized',
                colorSubText: goalValue == "burn"
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : const Color.fromRGBO(255, 255, 255, 0.8),
                colorText: goalValue != "burn"
                    ? const Color.fromRGBO(255, 255, 255, 0.8)
                    : const Color.fromRGBO(255, 255, 255, 1),
                colorButton: goalValue != "burn"
                    ? const Color.fromRGBO(255, 255, 255, 0.3)
                    : primaryColor),
          ),
      ],
    );
  }
}