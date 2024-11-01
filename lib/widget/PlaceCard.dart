import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/model/CalisthenicsPark.dart';

import '../theme/colors.dart';
import 'ShimmerLoading.dart';

class Placecard extends StatelessWidget {
  const Placecard({super.key, this.data});

  final CalisthenicsPark? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 4.3,
      width: context.width / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
        border: Border.all(color: secondaryColor, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: data?.picture ?? "",
              height: context.height / 12,
              width: context.width / 3,
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
                return ShimmerLoading();
              },
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?.name ?? "Nama Taman Kalisteknik",
                    style: TextStyle(
                        color: primaryTextColor, fontFamily: 'RubikMedium'),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: primaryTextColor),
                    child: Text(
                      data?.distance.toString() ?? "Jarak Taman",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  color: primaryColor),
              child: Center(
                child: Text(
                  "Lihat",
                  style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 16,
                      fontFamily: 'PoppinsBoldSemi'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlacesCard extends StatelessWidget {
  PlacesCard({super.key, this.data, this.height, this.width});

  final CalisthenicsPark? data;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data == null
          ? null
          : () => Get.toNamed('/placedetailpage', arguments: {"id": data?.id}),
      child: SizedBox(
        height: height,
        width: width ?? context.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: CachedNetworkImage(
                  imageUrl: data!.picture!,
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
                  placeholder: (context, url) => ShimmerLoading(
                    height: height,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data?.name ?? "Taman Kalisteknik",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'PoppinsBoldSemi',
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Text.rich(
                      TextSpan(
                          text:
                              "${data?.distance?.toStringAsFixed(1) ?? "Jarak Taman"} KM",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontFamily: 'PoppinsBoldSemi',
                          ),
                          children: [
                            TextSpan(
                              text: " From Your Location",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'PoppinsBoldSemi',
                              ),
                            ),
                          ]),
                    ),
                    // SizedBox(
                    //   height: 16,
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
