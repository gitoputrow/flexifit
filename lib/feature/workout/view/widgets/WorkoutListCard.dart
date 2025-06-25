import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/feature/authentification/view/HomeScreen.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/ShimmerLoading.dart';

class WorkoutListCard extends StatelessWidget {
  const WorkoutListCard(
      {super.key,
      this.imageUrl,
      this.workout_title,
      this.reps,
      this.isLoading = false});
  final String? imageUrl;
  final String? workout_title;
  final int? reps;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 110,
          width: 110,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: isLoading
                ? const ShimmerLoading(
                    isLoading: true,
                  )
                : InkWell(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor: tertiaryColor,
                              content: Container(
                                // height: context.height / 2,
                                // width: context.width,
                                // padding: EdgeInsets.all(16),
                                color: tertiaryColor,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl!,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        color: Colors.white,
                                        child: const Center(
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
                                      return const ShimmerLoading(
                                        isLoading: true,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return Container(
                          color: Colors.white,
                          child: const Center(
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
                        return const ShimmerLoading(
                          isLoading: true,
                        );
                      },
                    ),
                  ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLoading(
              isLoading: isLoading,
              child: Text(
                isLoading ? "Workout Title" : workout_title!,
                style: const TextStyle(
                    fontFamily: 'RubikMedium',
                    fontSize: 23,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ShimmerLoading(
              isLoading: isLoading,
              child: Text(
                "X $reps",
                style: const TextStyle(
                    fontFamily: 'RubikLight',
                    fontSize: 21,
                    color: Colors.white),
              ),
            ),
          ],
        )
      ],
    );
  }
}
