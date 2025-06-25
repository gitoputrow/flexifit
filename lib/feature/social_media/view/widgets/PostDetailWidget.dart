import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/model/UserPost.dart';
import 'package:pain/theme/colors.dart';

import '../../../../widget/ShimmerLoading.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget(
      {super.key,
      this.padding,
      this.isLoading = false,
      this.data,
      required this.userId,
      this.onDelete,
      this.onLike});

  final EdgeInsetsGeometry? padding;

  final bool isLoading;

  final UserPost? data;

  final String userId;

  final void Function()? onDelete;

  final void Function()? onLike;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading
                  ? const ShimmerLoading(
                      shape: BoxShape.circle,
                      child: CircleAvatar(
                        radius: 25,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: data?.profilepicture ?? "",
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
                      progressIndicatorBuilder: (context, url, progress) {
                        return const ShimmerLoading();
                      },
                      imageBuilder: (context, imageProvider) {
                        return CircleAvatar(
                          radius: 25,
                          backgroundImage: imageProvider,
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
              const SizedBox(
                width: 16,
              ),
              ShimmerLoading(
                isLoading: isLoading,
                child: Text(
                  data?.username ?? "username",
                  textScaleFactor: 1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                ),
              ),
              const Spacer(),
              data?.idUser == userId
                  ? InkWell(
                      onTap: onDelete,
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                        color: primaryColor,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          isLoading
              ? ShimmerLoading(
                  height: MediaQuery.of(context).size.height / 2.2,
                )
              : CachedNetworkImage(
                  imageUrl: data?.imageSource ?? "",
                  height: MediaQuery.of(context).size.height / 2.2,
                  width: context.width,
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
                  progressIndicatorBuilder: (context, url, progress) {
                    return const ShimmerLoading();
                  },
                ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: onLike,
                    child: Icon(
                      Icons.favorite,
                      color: data?.liked == true
                          ? primaryColor
                          : Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ShimmerLoading(
                    isLoading: isLoading,
                    child: Text(
                      isLoading ? "0" : data?.like.toString() ?? "null",
                      textScaleFactor: 1,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  const Icon(
                    Icons.comment,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ShimmerLoading(
                    isLoading: isLoading,
                    child: Text(
                      isLoading ? "0" : data?.comment.toString() ?? "null",
                      textScaleFactor: 1,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ShimmerLoading(
            isLoading: isLoading,
            child: RichText(
              textScaleFactor: 1,
              text: TextSpan(
                  text: "Caption : ",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(
                      text: '" ${data?.caption} "',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
