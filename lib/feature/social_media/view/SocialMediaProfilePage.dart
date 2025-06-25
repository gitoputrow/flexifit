import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pain/feature/social_media/controller/SocialMediaProfileController.dart';
import 'package:pain/feature/social_media/view/widgets/PostUserWidget.dart';
import 'package:pain/feature/social_media/view/widgets/UserRecordWidget.dart';
import 'package:pain/feature/social_media/view/widgets/UserSummaryCard.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomeTabBar.dart';

import '../../../widget/HeaderPageWidget.dart';
import '../../../widget/MediaWidget.dart';
import '../../../widget/ProfilePictureDisplayWidget.dart';
import '../../../widget/ShimmerLoading.dart';

class SocialMediaProfilePage extends GetView<SocialMediaProfileController> {
  const SocialMediaProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const HeaderPageWidget(
                text: "User Profile",
                padding: EdgeInsets.symmetric(horizontal: 24),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    controller.loading
                        ? const ShimmerLoading(
                            shape: BoxShape.circle,
                            child: CircleAvatar(radius: 40),
                          )
                        : CircleAvatar(
                            radius: 40,
                            child: CachedNetworkImage(
                              imageUrl: controller.user?.photoProfile ?? "",
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Container(
                                color: Colors.white,
                                child: const Center(
                                  child: Text("image_not_found",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12)),
                                ),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      const ShimmerLoading(
                                          shape: BoxShape.circle,
                                          child: CircleAvatar(radius: 40)),
                            ),
                          ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            isLoading: controller.loading,
                            child: Text(
                              "${controller.user?.name}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'PoppinsBoldSemi',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ShimmerLoading(
                            isLoading: controller.loading,
                            child: Text(
                              "@${controller.user?.username}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'PoppinsRegular',
                                color: secondaryTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(12),
                    //   decoration: const BoxDecoration(
                    //       color: primaryColor, shape: BoxShape.circle),
                    //   child: const Icon(
                    //     Icons.chat_rounded,
                    //     size: 26,
                    //     color: Colors.white,
                    //   ),
                    // )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ShimmerLoading(
                  isLoading: controller.loading,
                  child: UserSummaryCard(data: controller.user),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TabBarSecondary(
                  controller: controller.tabController,
                  texts: ['Post', 'Record'],
                  icons: [
                    Icons.photo_library_rounded,
                    Icons.fitness_center_rounded
                  ],
                ),
              ),
              // Expanded area for scrollable Tab content
              Expanded(
                child: LiquidPullToRefresh(
                  backgroundColor: primaryColor,
                  showChildOpacityTransition: false,
                  color: backgroundColor,
                  height: 140,
                  onRefresh: () async => await controller.getData(),
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      Obx(() {
                        return PostUserWidget(
                          data: controller.userPostData,
                          isLoading: controller.loading,
                          onRefresh: () async => await controller.getData(),
                        );
                      }),
                      Obx(() {
                        return UserRecordWidget(
                          data: controller.user?.recordChallengeData,
                          isLoading: controller.loading,
                        );
                      })
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
