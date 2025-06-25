import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pain/feature/places/models/ReportPlaceModel.dart';
import 'package:pain/widget/MediaWidget.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/ShimmerLoading.dart';

class ReportCard extends StatelessWidget {
  const ReportCard(
      {super.key,
      this.loading = false,
      this.data,
      this.width,
      this.isContentOverflow = false,
      this.canDelete = true, this.onDelete});

  final bool loading;

  final bool canDelete;

  final ReportPlaceModel? data;

  final void Function()? onDelete;

  final double? width;

  final bool isContentOverflow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    loading
                        ? ShimmerLoading(
                            shape: BoxShape.circle,
                            child: CircleAvatar(
                              radius: 25,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: data!.profilepicture!,
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
                                child: CircleAvatar(radius: 25),
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
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoading(
                            isLoading: loading,
                            child: Text(
                              overflow: !isContentOverflow
                                  ? TextOverflow.clip
                                  : TextOverflow.ellipsis,
                              loading ? "UserName" : data!.username!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "PoppinsBoldSemi",
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          ShimmerLoading(
                            isLoading: loading,
                            child: Text(
                              loading ? "UserNickName" : data!.userNickName!,
                              overflow: !isContentOverflow
                                  ? TextOverflow.clip
                                  : TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PoppinsRegular",
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (canDelete && data != null && data!.canDelete) ...[
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(Icons.delete, color: primaryColor),
                )
              ]
            ],
          ),
          Divider(
            height: 24,
            color: secondaryColor,
            thickness: 2,
          ),
          ShimmerLoading(
            isLoading: loading,
            child: Text(
              loading ? "Description" : data!.desc!,
              overflow: !isContentOverflow
                  ? TextOverflow.clip
                  : TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "PoppinsRegular",
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 80,
            // width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ShimmerLoading(
                    isLoading: loading,
                    child: GestureDetector(
                      onTap: () {
                        if (data != null) {
                          context.showPreviewMedia(
                            items: data!.media!,
                          );
                        }
                      },
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: data == null
                            ? null
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CachedNetworkImage(
                                        imageUrl:
                                            data!.media![index].thumbnail!,
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
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, progress) {
                                          return ShimmerLoading(
                                            isLoading: true,
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                // color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          );
                                        }),
                                    data!.media![index].type!.name == "video"
                                        ? Center(
                                            child: Icon(
                                            Icons.play_circle_filled,
                                            color: Colors.white,
                                            size: 40,
                                          ))
                                        : SizedBox()
                                  ],
                                ),
                              ),
                      ),
                    ));
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 16,
                );
              },
              itemCount: data == null ? 3 : data!.media!.length,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ShimmerLoading(
            isLoading: loading,
            child: Text(
                !loading
                    ? DateFormat("dd MMMM yyyy HH:mm:ss").format(data!.date!)
                    : "Tanggal Hari Ini",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "PoppinsRegular",
                  fontSize: 14,
                )),
          )
        ],
      ),
    );
  }
}
