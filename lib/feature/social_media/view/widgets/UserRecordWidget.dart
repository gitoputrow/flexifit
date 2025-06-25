import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pain/feature/authentification/models/UserData.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ShimmerLoading.dart';

class UserRecordWidget extends StatelessWidget {
  const UserRecordWidget({super.key, this.data, this.isLoading = false});

  final List<RecordChallengeDatum>? data;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemBuilder: (context, index) {
          return ShimmerLoading(
            isLoading: isLoading,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  // color: tertiaryColor,
                  borderRadius: BorderRadius.circular(20),
                  image: data?[index] == null
                      ? null
                      : DecorationImage(
                          opacity: 0.6,
                          image: Image.network(
                            data?[index].url ?? "",
                            loadingBuilder: (context, child, loadingProgress) =>
                                ShimmerLoading(
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ).image,
                          fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?[index].title ?? "Nama Challenge",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PoppinsBoldSemi',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beginner :",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'PoppinsRegular',
                            color: Colors.white),
                      ),
                      Text(
                        "${data?[index].level?.beginner}",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'PoppinsBoldSemi',
                            color: primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Intermediate :",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'PoppinsRegular',
                            color: Colors.white),
                      ),
                      Text(
                        "${data?[index].level?.intermediate}",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'PoppinsBoldSemi',
                            color: primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 16,
          );
        },
        itemCount: data == null ? 4 : data!.length);
  }
}
