import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconly/iconly.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/feature/places/controllers/PlacesDetailController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/CustomRichTextButton.dart';
import 'package:pain/widget/HeaderPageWidget.dart';
import 'package:pain/feature/places/views/widgets/ReportCard.dart';
import 'package:pain/widget/TextFieldCustom.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widget/ShimmerLoading.dart';

class PlacesDetailPageView extends GetView<PlacesDetailController> {
  const PlacesDetailPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                HeaderPageWidget(
                    isLoading: controller.loading,
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'PoppinsBoldSemi',
                        color: Colors.white),
                    text:
                        "${controller.loading ? "calisthenics_park_name" : controller.calisthenicsPark.name}"),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: LiquidPullToRefresh(
                    backgroundColor: primaryColor,
                    showChildOpacityTransition: false,
                    color: backgroundColor,
                    height: 140,
                    onRefresh: () async => await controller.getData(),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: controller.loading
                                        ? ShimmerLoading(
                                            height: context.height / 3.85)
                                        : CachedNetworkImage(
                                            imageUrl: controller
                                                .calisthenicsPark.picture!,
                                            height: context.height / 3.85,
                                            width: context.width,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) {
                                              return Container(
                                                color: Colors.white,
                                                child: const Center(
                                                  child: Text(
                                                    "image_not_found",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            progressIndicatorBuilder:
                                                (context, url, progress) {
                                              return ShimmerLoading(
                                                height: context.height / 3.85,
                                                width: context.width,
                                              );
                                            },
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        IconlyBold.location,
                                        color: secondaryTextColor,
                                        size: 24,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Flexible(
                                        child: ShimmerLoading(
                                            width: context.width / 2,
                                            isLoading: controller.loading,
                                            child: CustomRichTextButton(
                                                onTap: controller.loading
                                                    ? null
                                                    : () async => await launchUrl(
                                                        Uri.parse(controller
                                                            .calisthenicsPark
                                                            .linkMaps!),
                                                        mode: LaunchMode
                                                            .externalApplication),
                                                primaryText: controller
                                                            .calisthenicsPark
                                                            .fullAddress ==
                                                        null
                                                    ? "calisthenics_park_full_address"
                                                    : "${controller.calisthenicsPark.fullAddress}.",
                                                secondaryText:
                                                    " Open in Maps")),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Obx(() => ShimmerLoading(
                                        isLoading: controller.loading,
                                        borderRadiusValue: 20,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: secondaryColor),
                                          child: Text(
                                            "${controller.calisthenicsPark.distance?.toStringAsFixed(2)} KM Away From You!",
                                            style: const TextStyle(
                                                color: primaryTextColor,
                                                fontSize: 16,
                                                fontFamily: "PoppinsBoldSemi"),
                                          ),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Tools",
                                    style: TextStyle(
                                        color: primaryTextColor,
                                        fontSize: 24,
                                        fontFamily: "PoppinsBoldSemi"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  height: 260,
                                  child: PageView.builder(
                                      controller:
                                          PageController(viewportFraction: 0.9),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: ShimmerLoading(
                                                    isLoading:
                                                        controller.loading,
                                                    child: CachedNetworkImage(
                                                      imageUrl: controller
                                                              .calisthenicsPark
                                                              .tools?[index]
                                                              .picture ??
                                                          "",
                                                      height: 220,
                                                      width:
                                                          context.width / 1.17,
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                          url, error) {
                                                        return Container(
                                                          color: Colors.white,
                                                          child: const Center(
                                                            child: Text(
                                                              "image_not_found",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                              progress) {
                                                        return ShimmerLoading(
                                                            width:
                                                                context.width /
                                                                    1.17);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                ShimmerLoading(
                                                  isLoading: controller.loading,
                                                  child: Text(
                                                    controller
                                                            .calisthenicsPark
                                                            .tools?[index]
                                                            .name ??
                                                        "tools_Name",
                                                    style: const TextStyle(
                                                        color: primaryTextColor,
                                                        fontSize: 18,
                                                        fontFamily:
                                                            "PoppinsRegular"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                      itemCount: controller.loading
                                          ? 3
                                          : controller
                                              .calisthenicsPark.tools!.length),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Reports",
                                        style: TextStyle(
                                            color: primaryTextColor,
                                            fontSize: 24,
                                            fontFamily: "PoppinsBoldSemi"),
                                      ),
                                      if (controller
                                          .reportPlaceData.isNotEmpty) ...[
                                        GestureDetector(
                                          onTap: () => Get.toNamed(
                                              "/placereportpage",
                                              arguments: {
                                                "id": controller
                                                    .calisthenicsPark.id,
                                                'name': controller
                                                    .calisthenicsPark.name
                                              }),
                                          child: const Text(
                                            "See all...",
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 18,
                                                fontFamily: "PoppinsRegular"),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  height: controller.loading ||
                                          controller.reportPlaceData.isNotEmpty
                                      ? 290
                                      : null,
                                  child: Obx(() {
                                    return controller.loading ||
                                            controller
                                                .reportPlaceData.isNotEmpty
                                        ? ListView.separated(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  ReportCard(
                                                    canDelete: false,
                                                    isContentOverflow: true,
                                                    width: context.width / 2,
                                                    loading: controller.loading,
                                                    data: controller.loading
                                                        ? null
                                                        : controller
                                                                .reportPlaceData[
                                                            index],
                                                  )
                                                ],
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                            itemCount: controller.loading
                                                ? 2
                                                : controller
                                                    .reportPlaceData.length)
                                        : const Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Icon(
                                                Icons.report_off_rounded,
                                                color: primaryColor,
                                                size: 32,
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Center(
                                                child: Text(
                                                  "There's No Report",
                                                  style: TextStyle(
                                                      color: primaryTextColor,
                                                      fontSize: 18,
                                                      fontFamily:
                                                          "PoppinsRegular"),
                                                ),
                                              )
                                            ],
                                          );
                                  }),
                                ),
                                Obx(() => SizedBox(
                                      height: controller.loading ||
                                              controller
                                                  .reportPlaceData.isNotEmpty
                                          ? 80
                                          : 100,
                                    )),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonCustomMain(
                                  onPressed: () async {
                                    final result = await Get.toNamed(
                                        "/addreportpage",
                                        arguments: {
                                          "id": controller.calisthenicsPark.id,
                                          'name':
                                              controller.calisthenicsPark.name
                                        });
                                    if (result == true) {
                                      await controller.getData();
                                    }
                                  },
                                  title: "Add Report"),
                              SizedBox(
                                height: 24,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
