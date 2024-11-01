import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomDropdown.dart';
import 'package:pain/widget/PlaceCard.dart';

import '../../../widget/ShimmerLoading.dart';
import '../controllers/PlacesController.dart';

class Placespageview extends GetView<PlacesController> {
  const Placespageview({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Workout Place",
          style: TextStyle(
              fontSize: 20, fontFamily: 'PoppinsBoldSemi', color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          endIndent: MediaQuery.of(context).size.width / 1.95,
          thickness: 2,
          color: Color.fromRGBO(255, 255, 255, 0.5),
        ),
        SizedBox(
          height: 5,
        ),
        const Text(
          "Search Place to Workout",
          textScaleFactor: 1,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => ShimmerLoading(
            isLoading: controller.loading,
            child: CardCustomDropDown(
              labelText: "Choose Province",
              title: "Select Province",
              items: controller.items,
              initialValue: controller.selectedProvince,
              onChanged: (p0)async{
                controller.selectedProvince = p0!;
                await controller.getCalisthenicsParkData();
              },
            ),
          ),
        ),
        Expanded(
          child: LiquidPullToRefresh(
                    backgroundColor: primaryColor,
                    showChildOpacityTransition: false,
                    color: backgroundColor,
                    height: 140,
                    onRefresh: () async =>
                        await controller.getCalisthenicsParkData(),
                    child: Obx(() => ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: 28),
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        // Get.toNamed("/challangelevel", arguments: {
                        //   "title": controller.challangeData[index].title
                        // });
                      },
                      child: controller.loading || controller.loadingPlaces
                          ? ShimmerLoading(
                              height: context.height / 4,
                              borderRadiusValue: 20,
                            )
                          : PlacesCard(
                              height: context.height / 4,
                              data: controller.calisthenicsParkData[index]),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 35,
                    ),
                itemCount:
                    controller.loading || controller.loadingPlaces ? 3 : controller.calisthenicsParkData.length)),
          ),
        )
      ]),
    ));
  }
}
