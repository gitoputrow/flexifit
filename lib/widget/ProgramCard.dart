import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProgramCard extends StatelessWidget {
  double width;
  double height;
  String? imageUrl;
  File? imageSource;
  String days;
  String WorkoutName;
  void Function()? cameraTap;

  ProgramCard({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.days,
    this.cameraTap,
    this.imageSource,
    required this.WorkoutName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              imageUrl == null
                  ? Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                                        color: imageSource == null ? Color.fromRGBO(255, 255, 255, 0.125) : null,
                                        image: imageSource == null ? null : DecorationImage(
                                            image: FileImage(imageSource!),
                                            fit: BoxFit.cover
                                        )
                                    ),
                      child: imageSource ==null ? IconButton(
                        icon: Image.asset(
                          "asset/Image/cameraImage.png",
                          width: width / 6,
                        ),
                        onPressed: cameraTap,
                      ) : Text(""),
                    )
                  : CachedNetworkImage(
                      imageUrl:  imageUrl!,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
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
                            value:progress.progress,
                          ),
                        );
                      },
                    ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      days,
                      textScaleFactor: 1,
                      style:
                          TextStyle(fontSize: 35, fontFamily: 'RubikSemiBold', color: Colors.white),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      WorkoutName,
                      textScaleFactor: 1,
                      style:
                          TextStyle(fontSize: 18, fontFamily: 'RubikRegular', color: Colors.white),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
