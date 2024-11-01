import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CommentPostCard.dart';

import '../../../controller/SosialMediaController.dart';

class DetailPostPage extends GetView<SosialMediaController> {
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
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Image.asset(
                            "asset/Image/backwo.png",
                            width: 36,
                            height: 36,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          "Detail Post",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'PoppinsBoldSemi',
                              color: Colors.white),
                        ),
                        InkWell(
                          child: Image.asset(
                            "asset/Image/backwo.png",
                            width: 36,
                            height: 36,
                            color: Colors.transparent,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(color: disabledTextColor,),
                  
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        controller.userPost!.profilepicture!,
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        color: Colors.white,
                                        child: Center(
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
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromRGBO(170, 5, 27, 1),
                                          value: progress.progress,
                                        ),
                                      );
                                    },
                                    imageBuilder: (context, imageProvider) {
                                      return CircleAvatar(
                                        radius: 25,
                                        backgroundImage: imageProvider,
                                        backgroundColor: Colors.transparent,
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    controller.userPost!.username!,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22),
                                  ),
                                  Spacer(),
                                  controller.userPost!.id!.substring(controller
                                                  .userPost!.id!
                                                  .indexOf("|") +
                                              1) ==
                                          controller.userid
                                      ? InkWell(
                                          onTap: () async =>
                                              await controller.deletePost,
                                          child: Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Color.fromRGBO(203, 6, 33, 1),
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              CachedNetworkImage(
                                imageUrl: controller.userPost!.imageSource!,
                                height: MediaQuery.of(context).size.height / 2.2,
                                // width: MediaQuery.of(context).size.width / 1.3,
                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: Colors.white,
                                    child: Center(
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
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromRGBO(170, 5, 27, 1),
                                      value: progress.progress,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Obx(
                                        () {
                                          controller.testa.value;
                                          return InkWell(
                                            onTap: () async =>
                                                await controller.like(
                                                    controller.userPost!.id!
                                                        .substring(controller
                                                                .userPost!.id!
                                                                .indexOf("|") +
                                                            1),
                                                    controller.userPost!.id!),
                                            child: Icon(
                                              Icons.favorite,
                                              color: controller.userPost!.liked ==
                                                      true
                                                  ? Color.fromRGBO(170, 5, 27, 1)
                                                  : Colors.white,
                                              size: 32,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Obx(() {
                                        controller.testa.value;
                                        return Text(
                                          controller.userPost!.like.toString(),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        );
                                      })
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Obx(() {
                                        controller.testa.value;
                                        return Text(
                                          controller.userPost!.comment.toString(),
                                          textScaleFactor: 1,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        );
                                      })
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  textScaleFactor: 1,
                                  text: TextSpan(
                                      text: "Caption : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                          text:
                                              "' ${controller.userPost!.caption} '",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Divider(
                            color: Color.fromARGB(255, 89, 89, 89),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Obx(
                              () {
                                controller.testa.value;
                                return Text(
                                  "Comment (${controller.userPost!.comment})",
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                );
                              },
                            )),
                        SizedBox(
                          height: 24,
                        ),
                        Obx(() => controller.loadingComment == true
                            ? CircularProgressIndicator()
                            : controller.commentPost.length == 0
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) => CommentPostCard(
                                            commentPost:
                                                controller.commentPost[index],
                                            onDelete: () async => await controller.deleteComment(
                                                controller.commentPost[index].id!,
                                                context),
                                            buttonDelete: controller
                                                        .commentPost[index].id!
                                                        .substring(controller.commentPost[index].id!
                                                                .indexOf("|") +
                                                            1) ==
                                                    controller.userid ||
                                                controller.userPost!.id!.substring(
                                                        controller.userPost!.id!.indexOf("|") + 1) ==
                                                    controller.userid),
                                        separatorBuilder: (context, index) => SizedBox(
                                              height: 24,
                                            ),
                                        itemCount: controller.commentPost.length),
                                  )),
                        SizedBox(
                          height: 180,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 28, left: 24, right: 24),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: controller.comment,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              hintText: "add comment",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 145, 145, 145)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 0)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 0)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () async => await controller.addComment(context),
                          child: Text(
                            "Send",
                            style: TextStyle(
                                color: Color.fromRGBO(203, 6, 33, 1),
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
