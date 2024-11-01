import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pain/controller/DashboardController.dart';
import 'package:pain/feature/profile/controller/ProfileController.dart';
import 'package:pain/widget/PostUserCard.dart';

class MyProfilePage extends GetView<ProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     CachedNetworkImage(
        //       imageUrl: controller.user.photoprofile!,
        //       errorWidget: (context, url, error) {
        //         return Container(
        //           color: Colors.white,
        //           child: Center(
        //             child: Text(
        //               "image_not_found",
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 12,
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //       progressIndicatorBuilder: (context, url, progress) {
        //         return Center(
        //           child: CircularProgressIndicator(
        //             color: Color.fromRGBO(170, 5, 27, 1),
        //             value: progress.progress,
        //           ),
        //         );
        //       },
        //       imageBuilder: (context, imageProvider) {
        //         return CircleAvatar(
        //           radius: 40,
        //           backgroundImage: imageProvider,
        //           backgroundColor: Colors.transparent,
        //         );
        //       },
        //     ),
        //     SizedBox(
        //       width: 16,
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           controller.user.username!,
        //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
        //         ),
        //         SizedBox(
        //           height: 12,
        //         ),
        //         Text(
        //           controller.user.name!,
        //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        // SizedBox(
        //   height: 24,
        // ),
        // SizedBox(
        //   height: 75,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Body Weight",
        //             style:
        //                 TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
        //           ),
        //           SizedBox(
        //             height: 12,
        //           ),
        //           Text(
        //             "${controller.user.weight} Kg",
        //             style:
        //                 TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        //           ),
        //         ],
        //       ),
        //       VerticalDivider(
        //         width: 2,
        //         color: Color.fromARGB(255, 167, 167, 167),
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Post",
        //             style:
        //                 TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
        //           ),
        //           SizedBox(
        //             height: 12,
        //           ),
        //           Text(
        //             "${controller.userPostData.where((element) => element.id!.substring(element.id!.indexOf("|") + 1) == controller.userid).length}",
        //             style:
        //                 TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        //           ),
        //         ],
        //       ),
        //       VerticalDivider(
        //         width: 2,
        //         color: Color.fromARGB(255, 167, 167, 167),
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Body Height",
        //             style:
        //                 TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
        //           ),
        //           SizedBox(
        //             height: 12,
        //           ),
        //           Text(
        //             "${controller.user.height} Cm",
        //             style:
        //                 TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 24,
        // ),
        // Obx(() => controller.loadingPost == true
        //     ? CircularProgressIndicator()
        //     : controller.userPostData.where((element) => element.id!.substring(element.id!.indexOf("|") + 1) == controller.userid).toList().length ==
        //             0
        //         ? SizedBox()
        //         : ListView.separated(
        //             physics: NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             scrollDirection: Axis.vertical,
        //             itemBuilder: (context, index) => Obx(() => PostUserCard(
        //                 comment: () => Get.toNamed("/detailpostpage", arguments: [
        //                       controller.userid,
        //                       {
        //                         "post_data": controller.userPostData
        //                             .where((element) =>
        //                                 element.id!.substring(element.id!.indexOf("|") + 1) ==
        //                                 controller.userid)
        //                             .toList()[index]
        //                       },
        //                       "postdetail"
        //                     ])!
        //                         .then((value) async => await controller.getUserPostData()),
        //                 test: controller.testa.value,
        //                 userPost: controller.userPostData
        //                     .where((element) =>
        //                         element.id!.substring(element.id!.indexOf("|") + 1) ==
        //                         controller.userid)
        //                     .toList()[index],
        //                 deleted: true,
        //                 delete: () async => await controller.deletePost(controller.userPostData
        //                     .where((element) =>
        //                         element.id!.substring(element.id!.indexOf("|") + 1) ==
        //                         controller.userid)
        //                     .toList()[index]
        //                     .id!),
        //                 like: () async => await controller.like(
        //                     controller.userid,
        //                     controller.userPostData
        //                         .where((element) =>
        //                             element.id!.substring(element.id!.indexOf("|") + 1) ==
        //                             controller.userid)
        //                         .toList()[index]
        //                         .id!))),
        //             separatorBuilder: (context, index) => SizedBox(
        //                   height: 20,
        //                 ),
        //             itemCount: controller.userPostData
        //                 .where((element) => element.id!.substring(element.id!.indexOf("|") + 1) == controller.userid)
        //                 .length)),
      ],
    );
  }
}
