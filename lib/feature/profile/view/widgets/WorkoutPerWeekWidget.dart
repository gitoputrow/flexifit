import 'package:flutter/material.dart';
import 'package:pain/widget/ShimmerLoading.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/CustomRadioButtonCircle.dart';

class WorkoutPerWeekWidget extends StatelessWidget {
  const WorkoutPerWeekWidget(
      {super.key,
      this.isLoading = false,
      required this.physicValue,
      required this.onChange});

  final bool isLoading;

  final void Function(String section, String value) onChange;

  final String physicValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerLoading(
          borderRadiusValue: 32,
          isLoading: isLoading,
          child: CustomRadioButtonCircle(
            onPressed: () async {
              onChange("physic", "new");
            },
            title: "3",
            colorText: physicValue != "new"
                ? const Color.fromRGBO(255, 255, 255, 0.8)
                : const Color.fromRGBO(255, 255, 255, 1),
            colorButton: physicValue != "new"
                ? const Color.fromRGBO(255, 255, 255, 0.3)
                : primaryColor,
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        ShimmerLoading(
          borderRadiusValue: 32,
          isLoading: isLoading,
          child: CustomRadioButtonCircle(
            onPressed: () {
              onChange("physic", "pro");
            },
            title: "4",
            colorText: physicValue != "pro"
                ? const Color.fromRGBO(255, 255, 255, 0.8)
                : const Color.fromRGBO(255, 255, 255, 1),
            colorButton: physicValue != "pro"
                ? const Color.fromRGBO(255, 255, 255, 0.3)
                : primaryColor,
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        ShimmerLoading(
          borderRadiusValue: 32,
          isLoading: isLoading,
          child: CustomRadioButtonCircle(
            onPressed: () {
              onChange("physic", "master");
            },
            title: "5",
            colorText: physicValue != "master"
                ? const Color.fromRGBO(255, 255, 255, 0.8)
                : const Color.fromRGBO(255, 255, 255, 1),
            colorButton: physicValue != "master"
                ? const Color.fromRGBO(255, 255, 255, 0.3)
                : primaryColor,
          ),
        )
      ],
    );
  }
}
