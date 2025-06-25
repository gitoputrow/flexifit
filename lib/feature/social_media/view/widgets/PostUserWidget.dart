import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/model/UserPost.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/ShimmerLoading.dart';

class PostUserWidget extends StatelessWidget {
  const PostUserWidget({super.key, required this.data, this.isLoading = false, this.onRefresh});

  final List<UserPost> data;

  final bool isLoading;

  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return !isLoading && data.isEmpty
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.perm_media_rounded,
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
          )
        : CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return isLoading
                          ? const ShimmerLoading(borderRadiusValue: 12)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: GestureDetector(
                                onTap: () async{
                                  final result = await Get.toNamed("/detailpostpage", arguments: {
                                    "post_data": data[index],
                                    "id": data[index].id
                                  });
                                  if(result != null && onRefresh != null){
                                    onRefresh!();
                                  }
                                },
                                child: CachedNetworkImage(
                                  imageUrl: data[index].imageSource ?? '',
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.white,
                                    child: const Center(
                                      child: Text("image_not_found",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12)),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, progress) => const Center(
                                    child: ShimmerLoading(),
                                  ),
                                ),
                              ),
                            );
                    },
                    childCount: isLoading ? 3 : data.length,
                  ),
                ),
              ),
            ],
          );
  }
}
