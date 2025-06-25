import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/CustomRadioButton.dart';
import '../../../../widget/ShimmerLoading.dart';

class TargetZoneWidget extends StatelessWidget {
  const TargetZoneWidget({super.key, this.isLoading = false, required this.onChange, required this.muscleValue});

  final bool isLoading;

  final void Function(String section, String value) onChange;

  final List<String> muscleValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerLoading(
            isLoading: isLoading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                onChange("muscleTarget", "Abs");
              },
              isSelected: true,
              fontSize: 22,
              title: "Abs",
              colorText: !muscleValue.contains("Abs")
                  ? Colors.white
                  : const Color.fromRGBO(255, 255, 255, 1),
              colorButton: !muscleValue.contains("Abs")
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
                onChange("muscleTarget", "Arm's");
              },
              fontSize: 22,
              title: "Arms",
              isSelected: true,
              colorText: !muscleValue.contains("Arm's")
                  ? const Color.fromRGBO(255, 255, 255, 0.8)
                  : const Color.fromRGBO(255, 255, 255, 1),
              colorButton: !muscleValue.contains("Arm's")
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
                  onChange("muscleTarget", "Chest");
                },
                isSelected: true,
                fontSize: 22,
                title: "Chest",
                colorText: !muscleValue.contains("Chest")
                    ? const Color.fromRGBO(255, 255, 255, 0.8)
                    : const Color.fromRGBO(255, 255, 255, 1),
                colorButton: !muscleValue.contains("Chest")
                    ? const Color.fromRGBO(255, 255, 255, 0.3)
                    : primaryColor),
          ),
        const SizedBox(
          height: 20,
        ),
        ShimmerLoading(
            isLoading: isLoading,
            borderRadiusValue: 20,
            child: CustomRadioButton(
              onPressed: () {
                onChange("muscleTarget", "Leg's");
              },
              fontSize: 22,
              title: "Legs",
              isSelected: true,
              colorText: !muscleValue.contains("Leg's")
                  ? const Color.fromRGBO(255, 255, 255, 0.8)
                  : const Color.fromRGBO(255, 255, 255, 1),
              colorButton: !muscleValue.contains("Leg's")
                  ? const Color.fromRGBO(255, 255, 255, 0.3)
                  : primaryColor,
            ),
          ),
      ],
    );
  }
}