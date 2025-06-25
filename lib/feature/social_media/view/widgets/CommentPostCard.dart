import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:intl/intl.dart';
import 'package:pain/model/CommentPost.dart';
import 'package:pain/theme/colors.dart';

import '../../../../widget/ShimmerLoading.dart';

class CommentPostCard extends StatelessWidget {
  final CommentPost? commentPost;
  final void Function() onDelete;
  final bool isLoading;
  final bool buttonDelete;
  const CommentPostCard(
      {super.key,
      this.commentPost,
      this.isLoading = false,
      required this.onDelete,
      required this.buttonDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? const ShimmerLoading(
                    shape: BoxShape.circle,
                    child: CircleAvatar(
                      radius: 34,
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: commentPost?.profilePic ?? "",
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
                      return ShimmerLoading(
                        shape: BoxShape.circle,
                        child: CircleAvatar(
                          radius: 34,
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 34,
                        backgroundImage: imageProvider,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              width: context.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShimmerLoading(
                    isLoading: isLoading,
                    child: Text(
                      commentPost?.username ?? "username comment",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'PoppinsBoldSemi',
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ShimmerLoading(
                    isLoading: isLoading,
                    child: Text(
                      commentPost?.comment ?? "comment content",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "PoppinsReguler",
                          color: Color.fromRGBO(187, 187, 187, 1)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Spacer(),
            buttonDelete == true
                ? InkWell(
                    onTap: onDelete,
                    child: Icon(
                      Icons.delete,
                      size: 29,
                      color: primaryColor,
                    ),
                  )
                : SizedBox()
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerLoading(
              isLoading: isLoading,
              child: Text(
                () {
                  if (commentPost?.date != null &&
                      DateTime(commentPost!.date!.year, commentPost!.date!.month,
                              commentPost!.date!.day) ==
                          DateTime(DateTime.now().year, DateTime.now().month,
                              DateTime.now().day)) {
                    return "Today";
                  }
              
                  if (commentPost?.date != null &&
                      commentPost!.date!
                          .isAfter(DateTime.now().subtract(Duration(days: 7)))) {
                    return DateFormat("EEEE", "en")
                        .format(commentPost?.date ?? DateTime.now());
                  }
              
                  return DateFormat("yyyy-MM-dd")
                      .format(commentPost?.date ?? DateTime.now());
                }(),
                textScaleFactor: 1,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "PoppinsReguler",
                    color: tertiaryTextColor),
              ),
            ),
            ShimmerLoading(
              isLoading: isLoading,
              child: Text(
                DateFormat("HH:mm:ss")
                    .format(commentPost?.date ?? DateTime.now()),
                textScaleFactor: 1,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "PoppinsReguler",
                    color: tertiaryTextColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}
