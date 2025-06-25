import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pain/feature/authentification/models/UserData.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ShimmerLoading.dart';

class ProfilePictureDisplayWidget extends StatelessWidget {
  const ProfilePictureDisplayWidget(
      {super.key, this.data, this.tempFile, this.onEdit});

  final UserData? data;

  final File? tempFile;

  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return data == null
        ? const ShimmerLoading(
            shape: BoxShape.circle,
            child: CircleAvatar(
              radius: 53,
              backgroundColor: Colors.red,
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height / 9.3,
            width: MediaQuery.of(context).size.width / 4.5,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.transparent,
                              content: tempFile != null
                                  ? Image.file(tempFile!)
                                  : CachedNetworkImage(
                                      imageUrl: data!.photoProfile!,
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
                                      progressIndicatorBuilder:
                                          (context, url, progress) {
                                        return ShimmerLoading();
                                      },
                                      
                                    ),
                            ));
                  },
                  child: CachedNetworkImage(
                    imageUrl: data!.photoProfile!,
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
                            radius: 53,
                          ));
                    },
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 53,
                        backgroundImage: tempFile == null
                            ? imageProvider
                            : Image.file(tempFile!).image,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(top: 0, right: 1),
                  child: InkWell(
                    onTap: onEdit,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: primaryColor,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
