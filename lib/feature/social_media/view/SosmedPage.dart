import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/SearchBarCustomSosmed.dart';
import 'package:pain/widget/TextFieldCustom.dart';
import 'package:pain/widget/UserPostCard.dart';

import '../../../widget/BottomSheetPicture.dart';
import '../controller/SocialMediaController.dart';

class SosmedPage extends GetView<SocialMediaController> {
  const SosmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 24),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PAIN.",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  endIndent: MediaQuery.of(context).size.width / 1.95,
                  thickness: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 5,
                ),
                const Text(
                  "Social Media",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 24,
                ),
                SearchBarCustomSosmed(
                    textEditingController: controller.searchValue,
                    onTapSearch: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      await controller.search(controller.searchValue.text);
                    },
                    onTapAdd: () {
                      Get.bottomSheet(
                          BottomSheetPicture(pickImageCamera: () async {
                        await controller.pickImage(ImageSource.camera);
                      }, pickImageGallery: () {
                        controller.pickImage(ImageSource.gallery);
                      }));
                    }),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            Obx(() => Expanded(
                  child: LiquidPullToRefresh(
                    backgroundColor: primaryColor,
                    showChildOpacityTransition: false,
                    color: backgroundColor,
                    height: 140,
                    onRefresh: () async => await controller.getUserPostData(),
                    child: ListView.separated(
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
                                  ontapComment: () {
                                    Get.toNamed("/detailpostpage", arguments: [
                                      controller.userid,
                                      {"post_data": controller.userPostData[index]},
                                      "postdetail"
                                    ])!
                                        .then(
                                            (value) async => await controller.getUserPostData());
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
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ))
          ],
        ));
  }
}
