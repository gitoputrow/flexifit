import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/feature/social_media/controller/DetailSocialMediaController.dart';
import 'package:pain/feature/social_media/view/widgets/PostDetailWidget.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/feature/social_media/view/widgets/CommentPostCard.dart';
import 'package:pain/widget/HeaderPageWidget.dart';
import 'package:pain/widget/ShimmerLoading.dart';

class DetailPostPage extends GetView<Detailsocialmediacontroller> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  HeaderPageWidget(
                    result: controller.anyChange,
                    text: "Detail Post",
                    padding: EdgeInsets.symmetric(horizontal: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: disabledTextColor,
                    height: 0,
                  ),
                  Expanded(
                    child: LiquidPullToRefresh(
                      backgroundColor: primaryColor,
                      showChildOpacityTransition: false,
                      springAnimationDurationInMilliseconds: 500,
                      color: backgroundColor,
                      height: 140,
                      onRefresh: () async => await controller.getData(),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => PostDetailWidget(
                                  userId: controller.userid ?? "",
                                  data: controller.postData,
                                  isLoading: controller.loading,
                                  onDelete: () async => controller.deletePost(),
                                  onLike: () async => controller.like(),
                                )),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Divider(
                                color: Color.fromARGB(255, 89, 89, 89),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Obx(
                                  () {
                                    return ShimmerLoading(
                                      isLoading: controller.loadingComment,
                                      child: Text(
                                        "Comment (${controller.postData.comment})",
                                        textScaleFactor: 1,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    );
                                  },
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          CommentPostCard(
                                            isLoading:
                                                controller.loadingComment,
                                            commentPost: controller
                                                    .loadingComment
                                                ? null
                                                : controller.commentData[index],
                                            onDelete: () async =>
                                                await controller.deleteComment(
                                              controller
                                                  .commentData[index]!.id!,
                                            ),
                                            buttonDelete: !controller
                                                    .loadingComment &&
                                                (controller.commentData[index]!
                                                            .idUser ==
                                                        controller.userid ||
                                                    controller
                                                            .postData.idUser ==
                                                        controller.userid),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 24,
                                          ),
                                      itemCount: controller.loadingComment
                                          ? 3
                                          : controller.commentData.length),
                                )),
                            const SizedBox(
                              height: 180,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(bottom: 28, left: 24, right: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: controller.comment,
                            style: const TextStyle(fontSize: 20),
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: "Add Comment",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 145, 145, 145)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () async =>
                              await controller.addComment(context),
                          child: const Text(
                            "Send",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
