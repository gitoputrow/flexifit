import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pain/model/MediaModel.dart';
import 'package:pain/theme/colors.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import 'MediaWidget.dart';

class CustomUploadMediaForm extends StatelessWidget {
  CustomUploadMediaForm(
      {super.key,
      required this.name,
      this.label,
      this.labelStyle,
      this.isMultipleUpload = false,
      this.isRequired = false});

  final String name;
  final String? label;
  final bool isMultipleUpload;
  final TextStyle? labelStyle;
  bool isRequired;

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<dynamic>(
        name: name,
        validator: (val) {
          /// Returns error if the form is required but the value is null
          /// or empty
          if (isRequired && val == null) {
            return 'Fill The Form';
          }

          return null;
        },
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null) ...[
                Text.rich(TextSpan(
                    children: isRequired
                        ? [
                            const TextSpan(
                                text: "*",
                                style: TextStyle(
                                    fontFamily: "PoppinsBoldSemi",
                                    color: primaryColor,
                                    fontSize: 16))
                          ]
                        : null,
                    text: label,
                    style: labelStyle ??
                        const TextStyle(
                            fontFamily: "PoppinsBoldSemi",
                            color: Colors.white,
                            fontSize: 16))),
                const SizedBox(
                  height: 8,
                ),
              ],
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMultipleUpload
                          ? _MultipleUploadWidget(
                              value: field.value,
                              hasError:
                                  field.hasError && field.errorText != null,
                              onDelete: (index) {
                                List<Map> temp = List<Map>.from((field.value! as List<Map>));
                                temp.removeAt(index);
                                field.didChange(temp);
                              },
                              isLoading: value,
                              onTap: () {
                                context.showChooseDialogMedia(
                                    onTap: (file, type) async {
                                  if (file == null) return;
                                  isLoading.value = true;
                                  String thumbnail = type == MediaType.video
                                      ? (await VideoCompress.getFileThumbnail(
                                              file.path))
                                          .path
                                      : file.path;
                                  String result = type == MediaType.video
                                      ? (await VideoCompress.compressVideo(
                                              file.path,
                                              deleteOrigin: true,
                                              frameRate: 25,
                                              quality:
                                                  VideoQuality.LowQuality))!
                                          .file!
                                          .path
                                      : file.path;
                                  List<Map> temp = () {
                                    if (field.value == null) {
                                      return [
                                        {
                                          "path": result,
                                          "type": type,
                                          "thumbnail": thumbnail
                                        }
                                      ];
                                    } else {
                                      return List<Map>.from(
                                          (field.value! as List<Map>))
                                        ..add({
                                          "path": result,
                                          "type": type,
                                          "thumbnail": thumbnail
                                        });
                                    }
                                  }();
                                  field.didChange(temp);
                                  isLoading.value = false;
                                });
                              },
                            )
                          : _SingleUploadWidget(
                              value: field.value?[0],
                              isLoading: value as bool,
                              mediaType:
                                  field.value?[0]['type'] ?? MediaType.image,
                              onTap: () {
                                context.showChooseDialogMedia(
                                    onTap: (file, type) async {
                                  if (file == null) return;
                                  isLoading.value = true;
                                  String thumbnail = type == MediaType.video
                                      ? (await VideoCompress.getFileThumbnail(
                                              file.path))
                                          .path
                                      : file.path;
                                  String result = type == MediaType.video
                                      ? (await VideoCompress.compressVideo(
                                              file.path,
                                              deleteOrigin: true,
                                              frameRate: 25,
                                              quality:
                                                  VideoQuality.LowQuality))!
                                          .file!
                                          .path
                                      : file.path;
                                  field.didChange([
                                    {
                                      "path": result,
                                      "type": type,
                                      "thumbnail": thumbnail
                                    },
                                  ]);
                                  isLoading.value = false;
                                });
                              },
                              hasError:
                                  field.hasError && field.errorText != null,
                              onDelete: () {
                                field.didChange(null);
                              },
                            ),
                      if (field.hasError && field.errorText != null) ...[
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${field.errorText}',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontFamily: "PoppinsRegular"),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}

class _MultipleUploadWidget extends StatelessWidget {
  _MultipleUploadWidget(
      {super.key,
      this.hasError = false,
      this.value,
      this.onDelete,
      this.isLoading = false,
      this.onTap});

  List<Map>? value;
  void Function(int)? onDelete;
  void Function()? onTap;
  bool hasError;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 200,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: tertiaryColor,
                border: () {
                  if (hasError) {
                    return Border.all(color: primaryColor, width: 1.5);
                  }
                }()),
            child: isLoading
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Loading Media...",
                        style: TextStyle(
                            fontFamily: "PoppinsBoldSemi", color: Colors.white),
                      )
                    ],
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Upload Media",
                        style: TextStyle(
                            fontFamily: "PoppinsBoldSemi", color: Colors.white),
                      )
                    ],
                  ),
          ),
        ),
        if (value != null && value!.isNotEmpty) ...[
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: value!.length,
                separatorBuilder: (context, index) => const SizedBox(
                      width: 12,
                    ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => context.showPreviewMedia(
                      items: [
                        MediaModel(
                          filePath: value?[index]["path"],
                          type: value?[index]["type"],
                        )
                      ],
                    ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: Image.file(File(value?[index]
                                            ["thumbnail"] ??
                                        value?[index]["path"]))
                                    .image,
                                fit: BoxFit.cover,
                                opacity: .8,
                              )),
                              child: value![index]["type"] == MediaType.video
                                  ? const Center(
                                      child: Icon(
                                        Icons.play_circle,
                                        size: 32,
                                        color: Colors.white,
                                      ),
                                    )
                                  : null,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  if (onDelete != null) {
                                    onDelete!(index);
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ]
      ],
    );
  }
}

class _SingleUploadWidget extends StatelessWidget {
  _SingleUploadWidget(
      {super.key,
      this.value,
      this.hasError = false,
      this.onDelete,
      this.isLoading = false,
      this.mediaType = MediaType.image,
      this.onTap});

  Map? value;
  void Function()? onDelete;
  void Function()? onTap;
  bool hasError;
  bool isLoading;
  MediaType mediaType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: value == null
          ? onTap
          : () {
              context.showPreviewMedia(
                items: [MediaModel(filePath: value!['path'], type: mediaType)],
              );
            },
      child: Container(
        height: 200,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: tertiaryColor,
            border: () {
              if (value != null) {
                return Border.all(color: secondaryColor, width: 1.5);
              }
              if (hasError) {
                return Border.all(color: primaryColor, width: 1.5);
              }
            }()),
        child: isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Loading Media...",
                    style: TextStyle(
                        fontFamily: "PoppinsBoldSemi", color: Colors.white),
                  )
                ],
              )
            : value != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(fit: StackFit.expand, children: [
                      mediaType == MediaType.image
                          ? Image.file(
                              File(value!['thumbnail']),
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: tertiaryColor,
                                image: DecorationImage(
                                  image: Image.file(File(value!['thumbnail']))
                                      .image,
                                  fit: BoxFit.cover,
                                  opacity: .5,
                                ),
                              ),
                              child: Center(
                                child: const Icon(
                                  Icons.play_circle,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: InkWell(
                            onTap: onDelete,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: secondaryColor),
                              child: const Icon(Icons.close_rounded,
                                  size: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ]),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Upload Media",
                        style: TextStyle(
                            fontFamily: "PoppinsBoldSemi", color: Colors.white),
                      )
                    ],
                  ),
      ),
    );
  }
}

enum FormMediaType { single, multiple }
