import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/CustomDropdown.dart';
import 'package:pain/feature/places/views/widgets/PlaceCard.dart';

import '../../../widget/ShimmerLoading.dart';
import '../controllers/WorkoutPlacesController.dart';

class WorkoutPlacesPageView extends GetView<WorkoutPlacesController> {
  const WorkoutPlacesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Workout Place",
          style: TextStyle(
              fontSize: 20, fontFamily: 'PoppinsBoldSemi', color: Colors.white),
        ),
        const SizedBox(
          height: 5,
        ),
        Divider(
          endIndent: MediaQuery.of(context).size.width / 1.95,
          thickness: 2,
          color: const Color.fromRGBO(255, 255, 255, 0.5),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Search Place to Workout",
          textScaleFactor: 1,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            child: CardCustomDropDown(
              labelText: "Choose City",
              title: "Select Province",
              items: List.from(controller.items.map((e) => e.name)),
              initialValue: controller.selectedCity.name,
              onChanged: (p0) async {
                controller.selectedCity = controller.items
                    .firstWhere((element) => element.name == p0);
                await controller.getCalisthenicsParkData();
              },
            ),
          ),
        ),
        Expanded(
            child: Obx(
          () => controller.locError == true
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_disabled_rounded,
                        color: secondaryColor,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Location Error, Unable to fetch data",
                        style: TextStyle(
                            fontFamily: "PoppinsBoldSemi",
                            color: secondaryColor,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ButtonCustomMain(
                        onPressed: () async {
                          await controller.getCalisthenicsParkData();
                        },
                        title: "Try Again",
                        width: context.width / 2,
                      )
                    ],
                  ),
                )
              : LiquidPullToRefresh(
                  backgroundColor: primaryColor,
                  showChildOpacityTransition: false,
                  color: backgroundColor,
                  height: 140,
                  onRefresh: () async =>
                      await controller.getCalisthenicsParkData(),
                  child: Obx(() {
                    if (!(controller.loading || controller.loadingPlaces) &&
                        controller.calisthenicsParkData.isEmpty) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.place_rounded,
                            color: primaryColor,
                            size: 80,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: Text(
                            "No Place Found",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "PoppinsBoldSemi"),
                          ))
                        ],
                      );
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(vertical: 28),
                        itemBuilder: (context, index) => controller.loading ||
                                controller.loadingPlaces
                            ? ShimmerLoading(
                                height: context.height / 4.5,
                                borderRadiusValue: 20,
                              )
                            : PlacesCard(
                                height: context.height / 4.5,
                                data: controller.calisthenicsParkData[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 35,
                            ),
                        itemCount:
                            controller.loading || controller.loadingPlaces
                                ? 3
                                : controller.calisthenicsParkData.length);
                  }),
                ),
        ))
      ]),
    ));
  }
}
