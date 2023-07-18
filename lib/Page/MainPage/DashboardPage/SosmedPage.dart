import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/widget/SearchBarCustomSosmed.dart';
import 'package:pain/widget/TextFieldCustom.dart';
import 'package:pain/widget/UserPostCard.dart';

import '../../../widget/BottomSheetPicture.dart';

class SosmedPage extends GetView<DashboardController> {
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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
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
                Text(
                  "Social Media",
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: SearchBarCustomSosmed(
                      textEditingController: controller.searchValue,
                      onTapSearch: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await controller.search(controller.searchValue.text);
                      },
                      onTapAdd: () {
                        Get.bottomSheet(BottomSheetPicture(pickImageCamera: () async {
                          await controller.PickImage(ImageSource.camera);
                        }, pickImageGallery: () {
                          controller.PickImage(ImageSource.gallery);
                        }));
                      }),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
            Obx(() => controller.loadingPost == true
                ? CircularProgressIndicator()
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => await controller.getUserPostData(),
                      child: controller.userPostData.isEmpty
                          ? SizedBox()
                          : ListView.separated(
                              itemBuilder: (context, index) => Obx(() => UserPostCard(
                                    ontapDelete: () async =>
                                        controller.deletePost(controller.userPostData[index].id!),
                                    postUser: controller.userPostData[index].id!.substring(
                                            controller.userPostData[index].id!.indexOf("|") + 1) ==
                                        controller.userid,
                                    test: controller.testa.value,
                                    liked: controller.userPostData[index].liked,
                                    userPost: controller.userPostData[index],
                                    ontapLike: () async => await controller.like(
                                        controller.userPostData[index].id!.substring(
                                            controller.userPostData[index].id!.indexOf("|") + 1),
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
                                  )),
                              itemCount: controller.postLenght,
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
