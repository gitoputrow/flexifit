import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/social_media/controller/SearchUsernameController.dart';
import 'package:pain/theme/colors.dart';

import '../../../widget/HeaderPageWidget.dart';
import '../../../widget/SearchBarCustomSosmed.dart';
import '../../../widget/ShimmerLoading.dart';

class SearchUsernamePage extends GetView<SearchUsernameController> {
  const SearchUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            HeaderPageWidget(
              text: "Search User",
              padding: EdgeInsets.symmetric(horizontal: 24),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SearchBarCustomSosmed(
                  name: "search",
                  isSearch: true,
                  textEditingController: controller.searchValue,
                  onChanged: (p0) async {
                    controller.userList = [];
                    controller.loading = true;
                    if (p0?.isEmpty ?? true) {
                      controller.documentSnapshot.value = null;
                      
                    }
                    await controller.getUserList(value: p0);
                    controller.loading = false;
                  },
                )),
            Expanded(child: Obx(() {
              return ListView.separated(
                  padding: EdgeInsets.all(24),
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/userprofilepage", arguments: {"id": controller.userList[index].id});
                        },
                        child: Row(
                          children: [
                            controller.loading
                                ? const ShimmerLoading(
                                    shape: BoxShape.circle,
                                    child: CircleAvatar(
                                      radius: 30,
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl:
                                        controller.userList[index].photoProfile ??
                                            "",
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        color: Colors.white,
                                        child: const Center(
                                          child: Text(
                                            "image_not_found",
                                            textScaleFactor: 1,
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
                                      return const ShimmerLoading();
                                    },
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                        radius: 30,
                                        backgroundImage: imageProvider,
                                        backgroundColor: Colors.transparent,
                                      );
                                    },
                                  ),
                            SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerLoading(
                                    isLoading: controller.loading,
                                    child: Text(
                                      controller.userList[index].username ??
                                          "Username",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'PoppinsBoldSemi',
                                          color: primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  ShimmerLoading(
                                    isLoading: controller.loading,
                                    child: Text(
                                      controller.userList[index].name ?? "name",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'PoppinsRegular',
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  itemCount: controller.userList.length);
            }))
          ],
        ),
      ),
    );
  }
}
