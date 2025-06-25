import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:pain/widget/SearchBarCustomSosmed.dart';
import 'package:pain/widget/TextFieldCustom.dart';
import 'package:pain/feature/social_media/view/widgets/UserPostCard.dart';

import '../../../widget/MediaWidget.dart';
import '../controller/SocialMediaController.dart';

class SosmedPage extends GetView<SocialMediaController> {
  const SosmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 28,
          right: 28,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Social Media",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'PoppinsBoldSemi',
                      color: Colors.white),
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
                  "Post Your Progress & Result",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                        child: ButtonCustomMain(
                      onPressed: () {
                        Get.toNamed("/searchuserpage",);
                      },
                      title: "Search User",
                      borderRadius: 16,
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    Flexible(
                        child: ButtonCustomMain(
                      onPressed: () {
                        Get.bottomSheet(
                            BottomSheetMedia(pickImageCamera: () async {
                          await controller.pickImage(ImageSource.camera);
                        }, pickImageGallery: () {
                          controller.pickImage(ImageSource.gallery);
                        }));
                      },
                      title: "Add Post",
                      borderRadius: 16,
                    )),
                  ],
                ),

                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            Obx(() => Expanded(
                  child: LiquidPullToRefresh(
                    backgroundColor: primaryColor,
                    showChildOpacityTransition: false,
                    springAnimationDurationInMilliseconds: 500,
                    color: backgroundColor,
                    height: 140,
                    onRefresh: () async =>
                        await controller.getUserPostData(isRefresh: true),
                    child: () {
                      if (!controller.loading &&
                          controller.userPostData.isEmpty) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              Icons.photo_library_rounded,
                              color: primaryColor,
                              size: 80,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Center(
                                child: Text(
                              "No Post Found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "PoppinsBoldSemi"),
                            ))
                          ],
                        );
                      }

                      return ListView.separated(
                        controller: controller.scrollController,
                        itemBuilder: (context, index) => Obx(() => controller
                                .loading
                            ? UserPostCard(
                                isLoading: true,
                              )
                            : index < controller.userPostData.length
                                ? UserPostCard(
                                    isLoading: controller.loading,
                                    ontapDelete: () async => controller.loading
                                        ? null
                                        : controller.deletePost(
                                            controller.userPostData[index].id!),
                                    postUser: controller.loading
                                        ? false
                                        : controller.userPostData[index].id!
                                                .substring(controller
                                                        .userPostData[index].id!
                                                        .indexOf("|") +
                                                    1) ==
                                            controller.userid,
                                    liked: controller.loading
                                        ? null
                                        : controller.userPostData[index].liked,
                                    userPost: controller.loading
                                        ? null
                                        : controller.userPostData[index],
                                    ontapLike: () async => controller.loading
                                        ? null
                                        : await controller.like(
                                            controller.userPostData[index].id!
                                                .substring(controller
                                                        .userPostData[index].id!
                                                        .indexOf("|") +
                                                    1),
                                            controller.userPostData[index].id!),
                                    ontapComment: () async {
                                      final result = await Get.toNamed(
                                          "/detailpostpage",
                                          arguments: {
                                            "post_data":
                                                controller.userPostData[index],
                                            "id": controller
                                                .userPostData[index].id
                                          });
                                      if (result == true) {
                                        await controller.getUserPostData(
                                            isRefresh: true);
                                      }
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  )),
                        itemCount: controller.loading
                            ? 2
                            : controller.loadMore
                                ? controller.userPostData.length + 1
                                : controller.userPostData.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.vertical,
                      );
                    }(),
                  ),
                ))
          ],
        ));
  }
}
