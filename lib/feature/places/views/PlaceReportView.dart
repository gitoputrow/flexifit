import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/feature/places/controllers/ReportsPlaceController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/HeaderPageWidget.dart';
import 'package:pain/feature/places/views/widgets/ReportCard.dart';

import '../../../widget/CustomButton.dart';
import '../../../widget/ShimmerLoading.dart';

class PlaceReportView extends GetView<ReportsPlaceController> {
  const PlaceReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, res) {
        if (!didPop) {
          Get.back(result: controller.result);
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            HeaderPageWidget(
              text: "Reports Issue",
              result: controller.result,
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: LiquidPullToRefresh(
                  backgroundColor: primaryColor,
                  showChildOpacityTransition: false,
                  color: backgroundColor,
                  height: 140,
                  onRefresh: () async => await controller.getData(),
                  child: Obx(() {
                    return ListView.separated(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                        itemBuilder: (context, index) => ReportCard(
                              onDelete: () {
                                controller.onDeleteReport(index);
                              },
                              data: controller.loading
                                  ? null
                                  : controller.reportPlaceData[index],
                              loading: controller.loading,
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16,
                            ),
                        itemCount: controller.loading
                            ? 2
                            : controller.reportPlaceData.length);
                  })),
            ),
          ],
        )),
      ),
    );
  }
}
