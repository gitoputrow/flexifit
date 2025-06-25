import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/models/UserData.dart';
import 'package:pain/widget/ShimmerLoading.dart';

import '../../../../theme/colors.dart';
import '../../../../widget/CustomButton.dart';

class SocialMediaSummaryCard extends StatelessWidget {
  const SocialMediaSummaryCard({super.key, this.data, this.isLoading = false});

  final UserData? data;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/userprofilepage", arguments: {"id": data?.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: tertiaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Post : ",
                    textScaleFactor: 1,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RubikReguler',
                        color: Colors.white)),
                
                ShimmerLoading(
                  isLoading: isLoading,
                  child: Text("${data?.post}",
                      textScaleFactor: 1,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RubikReguler',
                          color: Colors.white)),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor
                  ),
                  child: Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                )
              ],
            ),
            // SizedBox(
            //   height: 16,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Like",
            //         textScaleFactor: 1,
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontFamily: 'RubikReguler',
            //             color: Colors.white)),
            //     ShimmerLoading(
            //       isLoading: isLoading,
            //       child: Text("${data?.like}",
            //           textScaleFactor: 1,
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontFamily: 'RubikReguler',
            //               color: Colors.white)),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Comment",
            //         textScaleFactor: 1,
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontFamily: 'RubikReguler',
            //             color: Colors.white)),
            //     ShimmerLoading(
            //       isLoading: isLoading,
            //       child: Text("${data?.comment}",
            //           textScaleFactor: 1,
            //           style: TextStyle(
            //               fontSize: 20,
            //               fontFamily: 'RubikReguler',
            //               color: Colors.white)),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // ButtonCustomMain(
            //   onPressed: () {
            //     Get.toNamed("/userprofilepage", arguments: {"id": data?.id});
            //   },
            //   title: "See My Profile",
            //   borderRadius: 16,
            //   padding: EdgeInsets.all(12),
            // )
          ],
        ),
      ),
    );
  }
}
