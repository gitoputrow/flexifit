import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconly/iconly.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/feature/places/controllers/PlacesDetailController.dart';
import 'package:pain/theme/colors.dart';
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Image.asset(
                          "asset/Image/backwo.png",
                          width: 34,
                          height: 34,
                        ),
                      ),
                      ShimmerLoading(
                        isLoading: controller.loading,
                        child: Flexible(
                          child: Text(
                            "${controller.loading ? "calisthenics_park_name" : controller.calisthenicsPark.name}",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'PoppinsBoldSemi',
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Image.asset(
                        "asset/Image/backwo.png",
                        width: 34,
                        height: 34,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: LiquidPullToRefresh(
                    backgroundColor: primaryColor,
                    showChildOpacityTransition: false,
                    color: backgroundColor,
                    height: 140,
                    onRefresh: () async =>
                        await controller.getCalisthenicsParkData(),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                            child: Center(
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
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    IconlyBold.location,
                                    color: secondaryTextColor,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: ShimmerLoading(
                                      width: context.width /2,
                                      isLoading: controller.loading,
                                      child: GestureDetector(
                                        onTap: controller.loading
                                            ? null
                                            : () async => await launchUrl(
                                                Uri.parse(controller
                                                    .calisthenicsPark
                                                    .linkMaps!),
                                                mode: LaunchMode
                                                    .externalApplication),
                                        child: Text.rich(
                                          TextSpan(
                                              text: controller.calisthenicsPark
                                                          .fullAddress ==
                                                      null
                                                  ? "calisthenics_park_full_address"
                                                  : "${controller.calisthenicsPark.fullAddress}.",
                                              children: [
                                                TextSpan(
                                                    text: " Open in Maps",
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "PoppinsBoldSemi"))
                                              ],
                                              style: TextStyle(
                                                  color: secondaryTextColor,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      "PoppinsRegular")),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Obx(() => ShimmerLoading(
                                    isLoading: controller.loading,
                                    borderRadiusValue: 20,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: primaryColor),
                                      child: Text(
                                        "${controller.calisthenicsPark.distance?.toStringAsFixed(2)} KM Away From You!",
                                        style: TextStyle(
                                            color: primaryTextColor,
                                            fontSize: 16,
                                            fontFamily: "PoppinsBoldSemi"),
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Tools",
                                style: TextStyle(
                                    color: primaryTextColor,
                                    fontSize: 24,
                                    fontFamily: "PoppinsBoldSemi"),
                              ),
                            ),
                            SizedBox(
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
                                                  isLoading: controller.loading,
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller
                                                        .calisthenicsPark
                                                        .tools?[index]
                                                        .picture ?? "",
                                                    height: 220,
                                                    width: context.width / 1.17,
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Container(
                                                        color: Colors.white,
                                                        child: Center(
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
                                                          width: context.width /
                                                              1.17);
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              ShimmerLoading(
                                                isLoading: controller.loading,
                                                child: Text(
                                                  controller.calisthenicsPark
                                                          .tools?[index].name ??
                                                      "tools_Name",
                                                  style: TextStyle(
                                                      color: primaryTextColor,
                                                      fontSize: 18,
                                                      fontFamily:
                                                          "PoppinsBoldSemi"),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                  itemCount: controller.loading
                                      ? 3
                                      : controller
                                          .calisthenicsPark.tools!.length),
                            )
                          ]),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
