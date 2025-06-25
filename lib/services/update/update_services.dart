import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:url_launcher/url_launcher.dart';

bool skipUpdate = false;

class UpdateServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future getUpdateStatus() async {
    try {
      final pkgInfo = await PackageInfo.fromPlatform();

      String os = Platform.isAndroid ? "android" : "ios";

      final data = await firestore.collection("updateData").doc(os).get();

      UpdateModels dataUpdate =
          UpdateModels.fromJson(json.decode(json.encode(data.data())));

      if (int.parse(pkgInfo.buildNumber) < dataUpdate.version! &&
          skipUpdate == false) {
        Get.to(() => _UpdateView(
              data: dataUpdate,
              version: int.parse(pkgInfo.buildNumber),
            ));
      } else {
        skipUpdate = true;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

class _UpdateView extends StatelessWidget {
  const _UpdateView({required this.data, required this.version});

  final UpdateModels data;
  final int version;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor,
        body: Stack(fit: StackFit.expand, children: [
          Opacity(
            opacity: 0.2,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 124, 124, 124),
                  BlendMode.saturation),
              child: Image.network(
                data.imageBackground ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SafeArea(
                  child: Text(
                    data.title ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "PoppinsBold",
                        color: Colors.white),
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.sizeOf(context).height * 0.012,
                    // ),

                    Image.asset(
                      'asset/Icon/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.052,
                    ),
                    Text(
                      data.message ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "PoppinsBoldSemi",
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
                Row(
                  children: [
                    if (version < data.minVersion!) ...[
                      Flexible(
                        child: ButtonCustomMain(
                          onPressed: () async {
                            Navigator.pop(context, [true]);
                          },
                          title: "Lewati",
                          primary: tertiaryColor,
                          borderSide:
                              BorderSide(color: primaryColor, width: 1.5),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                    Flexible(
                      child: ButtonCustomMain(
                          onPressed: () async {
                            Navigator.pop(context, [true]);
                          },
                          title: "Update"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class UpdateModels {
  int? version;
  int? minVersion;
  String? url;
  String? title;
  String? message;
  String? imageBackground;

  UpdateModels({
    this.version,
    this.imageBackground,
    this.minVersion,
    this.message,
    this.title,
    this.url,
  });

  UpdateModels copyWith({
    int? version,
    int? minVersion,
    String? url,
    String? title,
    String? message,
    String? imageBackground,
  }) =>
      UpdateModels(
        version: version ?? this.version,
        minVersion: minVersion ?? this.minVersion,
        url: url ?? this.url,
        imageBackground: imageBackground ?? this.imageBackground,
        title: title ?? this.title,
        message: message ?? this.message,
      );

  factory UpdateModels.fromJson(Map<String, dynamic> json) => UpdateModels(
        version: json["version"],
        minVersion: json["minVersion"],
        url: json["url"],
        title: json["title"],
        imageBackground: json["imageBackground"],
        message: json["message"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "title": title,
  //       "description": description,
  //       "file": file,
  //       "notificationId": notificationId,
  //       "active": active,
  //       "fileType": fileType,
  //       "createdBy": createdBy,
  //       "updatedBy": updatedBy,
  //       "createdAt": createdAt?.toIso8601String(),
  //     };
}
