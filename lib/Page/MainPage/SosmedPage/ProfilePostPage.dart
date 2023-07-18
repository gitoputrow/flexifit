import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/controller/SosialMediaController.dart';
import 'package:pain/widget/BasicLoader.dart';

import '../../../widget/PostUserCard.dart';

class ProfilePostPage extends GetView<SosialMediaController> {
  const ProfilePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(10, 12, 13, 1),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Profile Detail",
                    textScaleFactor: 1,
                    style:
                        TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Obx(() => controller.loadingUserData == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.userData!.photoprofile!,
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
                                progressIndicatorBuilder: (context, url, progress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromRGBO(170, 5, 27, 1),
                                      value: progress.progress,
                                    ),
                                  );
                                },
                                imageBuilder: (context, imageProvider) {
                                  return CircleAvatar(
                                    radius: 40,
                                    backgroundImage: imageProvider,
                                    backgroundColor: Colors.transparent,
                                  );
                                },
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.userData!.username!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    controller.userData!.name!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Body Weight",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "${controller.userData!.weight} Kg",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 167, 167),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Post",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      controller.userPostData.length.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 167, 167),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Body Height",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "${controller.userData!.height} Cm",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => Obx(() => PostUserCard(
                                  comment: () async {
                                    Get.dialog(BasicLoader());
                                    controller.userPost = controller.userPostData[index];
                                    controller.mode = "postdetail";
                                    await controller.getPostComment();
                                    Get.back();
                                    Get.toNamed("/detailpostpage")!.then(
                                        (value) async => await controller.getUserSosmedData());
                                  },
                                  test: controller.testa.value,
                                  userPost: controller.userPostData[index],
                                  deleted: false,
                                  delete: () {},
                                  like: () async => await controller.like(
                                      controller.userPostData[index].id!.substring(
                                          controller.userPostData[index].id!.indexOf("|") + 1),
                                      controller.userPostData[index].id!))),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 20,
                                  ),
                              itemCount: controller.userPostData.length)
                        ],
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
