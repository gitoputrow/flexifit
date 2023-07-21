import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pain/model/ProgramWO.dart';

class ProgramCard extends StatelessWidget {
  double width;
  double height;
  ProgramWO programWO;

  ProgramCard({
    Key? key,
    required this.width,
    required this.height,
    required this.programWO,
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
              CachedNetworkImage(
                      imageUrl: programWO.picture!,
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
                            value: progress.progress,
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
                      programWO.day!,
                      textScaleFactor: 1,
                      style:
                          TextStyle(fontSize: 35, fontFamily: 'RubikSemiBold', color: Colors.white),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text(
                      programWO.title!,
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
