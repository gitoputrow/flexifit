import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain/model/BodyInformation.dart';
import 'package:pain/widget/ShimmerLoading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/colors.dart';

class BodyInformationContent extends StatelessWidget {
  const BodyInformationContent({super.key, this.data});

  final BodyInformationDetail? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerLoading(
              isLoading: data == null,
              child: Text(
                data?.title ?? "Judul Informasi",
                textScaleFactor: 1,
                style: const TextStyle(
                    color: primaryTextColor,
                    fontFamily: 'RubikMedium',
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            ShimmerLoading(
              isLoading: data == null,
              child: Text(
                data?.value ?? "Informasi",
                textScaleFactor: 1,
                style: const TextStyle(
                    color: primaryColor,
                    fontFamily: 'RubikSemiBold',
                    fontSize: 18),
              ),
            ),
          ],
        ),
        ShimmerLoading(
          isLoading: data == null,
          child: data?.info == null
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: secondaryColor,
                      builder: (context) {
                        return Container(
                          height: context.height / 2,
                          width: context.width,
                          padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                          decoration: const BoxDecoration(
                              // color: secondaryColor,
                              borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          )),
                          child: Column(
                            children: [
                              Text(
                                data!.info!.title!,
                                style: const TextStyle(
                                    color: primaryTextColor,
                                    fontFamily: 'PoppinsBoldSemi',
                                    fontSize: 22),
                              ),
                              Expanded(
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      data!.info!.body!,
                                      style: const TextStyle(
                                          color: primaryTextColor,
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Formula : \n${data!.info!.formula!}",
                                      style: const TextStyle(
                                          color: primaryTextColor,
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    const Text(
                                      "Source",
                                      style: TextStyle(
                                          color: primaryTextColor,
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            launchUrl(Uri.parse(data!.info!.source![index].value!));
                                          },
                                          child: Text(
                                              data!.info!.source![index].title!,
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontFamily: 'PoppinsBoldSemi',
                                                  fontSize: 20)),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 4),
                                        shrinkWrap: true,
                                        itemCount: data!.info!.source!.length),
                                        SizedBox(height: 24,)
                                  ],
                    
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.info_rounded,
                    color: disabledTextColor,
                  ),
                ),
        )
      ],
    );
  }
}
