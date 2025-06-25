import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pain/model/MediaModel.dart';
import 'package:pain/theme/colors.dart';
import 'package:pain/widget/CustomButton.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MediaChooseDialog extends StatelessWidget {
  MediaChooseDialog({super.key, this.onTap});

  void Function(XFile?, MediaType?)? onTap;

  @override
  Widget build(BuildContext context) {
    void showCustomBottomSheet(
      MediaType type,
    ) {
      showModalBottomSheet(
          context: context,
          backgroundColor: const Color.fromRGBO(55, 55, 55, 1),
          builder: (context) {
            return BottomSheetMedia(
              type: type,
              onTap: onTap,
            );
          });
    }

    return AlertDialog(
      backgroundColor: tertiaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose Media Type",
            style: TextStyle(
                fontFamily: "PoppinsBoldSemi",
                fontSize: 18,
                color: Colors.white),
          ),
          const SizedBox(
            height: 28,
          ),
          ButtonCustomMain(
            padding: const EdgeInsets.all(12),
            onPressed: () {
              Navigator.pop(context);
              showCustomBottomSheet(MediaType.image);
            },
            title: "Image",
            borderRadius: 12,
            icon: const Icon(Icons.image, color: Colors.white, size: 24),
            iconPosition: IconPosition.left,
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonCustomMain(
            padding: const EdgeInsets.all(12),
            onPressed: () {
              Navigator.pop(context);
              showCustomBottomSheet(MediaType.video);
            },
            title: "Video",
            borderRadius: 12,
            iconPosition: IconPosition.left,
            icon: const Icon(Icons.video_file, color: Colors.white, size: 24),
          )
        ],
      ),
    );
  }
}

class BottomSheetMedia extends StatefulWidget {
  void Function()? pickImageCamera;
  void Function()? pickImageGallery;
  void Function(XFile?, MediaType?)? onTap;

  MediaType? type;

  BottomSheetMedia(
      {Key? key,
      this.pickImageCamera,
      this.pickImageGallery,
      this.onTap,
      this.type})
      : super(key: key);

  @override
  State<BottomSheetMedia> createState() => _BottomSheetMediaState();
}

class _BottomSheetMediaState extends State<BottomSheetMedia> {
  Future<void> _pickMedia(ImageSource source) async {
    try {
      final media = widget.type == MediaType.image
          ? await ImagePicker().pickImage(source: source, imageQuality: 50)
          : await ImagePicker().pickVideo(
              source: source, maxDuration: const Duration(seconds: 90));
      if (media == null) return;
      if (widget.onTap != null) {
        widget.onTap!(media, widget.type);
      }
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Color.fromRGBO(55, 55, 55, 1),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Add Media',
            style: TextStyle(
                fontSize: 22, fontFamily: 'RubikReguler', color: Colors.white),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: widget.pickImageCamera ??
                    () {
                      _pickMedia(ImageSource.camera);
                    },
                color: primaryColor,
                textColor: Colors.white,
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 30,
                ),
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
              ),
              const SizedBox(
                width: 20,
              ),
              MaterialButton(
                onPressed: widget.pickImageGallery ??
                    () {
                      _pickMedia(ImageSource.gallery);
                    },
                color: primaryColor,
                textColor: Colors.white,
                child: const Icon(
                  Icons.image_rounded,
                  size: 30,
                ),
                padding: const EdgeInsets.all(16),
                shape: const CircleBorder(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _MediaPreviewDialog extends StatelessWidget {
  _MediaPreviewDialog({super.key, required this.items});

  final List<MediaModel> items;
  final ValueNotifier<MediaModel?> selectedImage = ValueNotifier(null);
  final ValueNotifier<bool> restartRender = ValueNotifier(false);
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        // Ensure Positioned is inside Stack
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: selectedImage,
                      builder: (context, state, _) {
                        MediaModel item = state ?? items.first;
                        if (item.type!.name == "video") {
                          return ValueListenableBuilder(
                            valueListenable: restartRender,
                            builder: (context, value, child) {
                              return _MediaVideoContainer(
                                data: item,
                                restartRender: value,
                              );
                            },
                          );
                        }

                        return _MediaImageContainer(
                          data: item,
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (items.length != 1) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final item = items.elementAt(index);

                      return ValueListenableBuilder(
                        valueListenable: selectedIndex,
                        builder: (context, value, _) {
                          return GestureDetector(
                            onTap: () {
                              restartRender.value = selectedImage.value != item;
                              selectedImage.value = item;
                              selectedIndex.value = index;
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                restartRender.value = false;
                              });
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: tertiaryColor,
                                border: Border.all(
                                  width: 6,
                                  color: value == index
                                      ? primaryColor
                                      : tertiaryColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    if (item.type == MediaType.video) ...[
                                      _PreviewMediaVideo(
                                        data: item,
                                      )
                                    ] else ...[
                                      CachedNetworkImage(
                                        imageUrl: item.path ?? "",
                                        fit: BoxFit.cover,
                                        errorWidget: (_, __, ___) {
                                          return Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Icon(
                                              Icons.info,
                                              color: secondaryColor,
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                            ),
                                          );
                                        },
                                      )
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}

class _MediaImageContainer extends StatelessWidget {
  _MediaImageContainer({super.key, this.data});

  MediaModel? data;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: tertiaryColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: data!.filePath != null
              ? Image.file(
                  File(data!.filePath!),
                )
              : CachedNetworkImage(
                  imageUrl: data!.path!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                    );
                  },
                  progressIndicatorBuilder: (context, url, progress) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  },
                )),
    ));
  }
}

class _PreviewMediaVideo extends StatefulWidget {
  const _PreviewMediaVideo({super.key, required this.data});

  final MediaModel data;

  @override
  State<_PreviewMediaVideo> createState() => _PreviewMediaVideoState();
}

class _PreviewMediaVideoState extends State<_PreviewMediaVideo> {
  String? thumbnail;

  void getThumbnail() async {
    thumbnail = await VideoThumbnail.thumbnailFile(
      video: widget.data.path!,
      quality: 50,
      imageFormat: ImageFormat.JPEG,
    );
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getThumbnail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.black,
        image: thumbnail == null
            ? null
            : DecorationImage(
                image: Image.file(File(thumbnail ?? "")).image,
                opacity: 0.8,
                fit: BoxFit.cover),
      ),
      child: Center(
        child: thumbnail == null
            ? const CircularProgressIndicator(
                color: primaryColor,
              )
            : Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              ),
      ),
    );
  }
}

class _MediaVideoContainer extends StatefulWidget {
  const _MediaVideoContainer({required this.data, this.restartRender = false});

  final MediaModel data;

  final bool restartRender;

  @override
  State<_MediaVideoContainer> createState() => _MediaVideoContainerState();
}

class _MediaVideoContainerState extends State<_MediaVideoContainer> {
  @override
  void initState() {
    initVideoController();
    super.initState();
  }

  void initVideoController() {
    _controller = widget.data.filePath != null
        ? VideoPlayerController.file(
            File(widget.data.filePath!),
          )
        : VideoPlayerController.networkUrl(
            Uri.parse(widget.data.path!),
          );

    _controller?.initialize().then((value) {});
    _controller?.addListener(() async {
      final VideoPlayerValue value = _controller!.value;

      final Duration videoDuration = value.duration;
      final String durationInMinutes =
          videoDuration.inMinutes.toString().padLeft(2, '0');
      final String durationInSeconds =
          videoDuration.inSeconds.toString().padLeft(2, '0');

      final Duration position = value.position;
      final String positionInMinutes =
          position.inMinutes.toString().padLeft(2, '0');
      final String positionInSeconds =
          position.inSeconds.toString().padLeft(2, '0');
      setState(() {
        duration =
            '$positionInMinutes:$positionInSeconds/$durationInMinutes:$durationInSeconds';
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  VideoPlayerController? _controller;

  bool isRotated = false;
  String duration = '00:00/00:00';

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: tertiaryColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: !_controller!.value.isInitialized
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Sedang memuat video',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "PoppinsBoldSemi",
                        ),
                      ),
                    )
                  ])
            : Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 64,
                      padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 8,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Text(
                                duration,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: "PoppinsBoldSemi",
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () async {
                                if (_controller!.value.isPlaying) {
                                  _controller!.pause();
                                } else {
                                  _controller!.play();
                                }
                              },
                              icon: Icon(
                                _controller!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: primaryColor,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

enum PickMediaMode { camera, gallery }

enum MediaType { image, video }

extension BuildContextX on BuildContext {
  void showPreviewMedia({required List<MediaModel> items}) async {
    showDialog(
        context: this, builder: (context) => _MediaPreviewDialog(items: items));
  }

  void showChooseDialogMedia({
    void Function(XFile?, MediaType?)? onTap,
  }) async {
    showDialog(
        context: this,
        builder: (context) {
          return MediaChooseDialog(
            onTap: onTap,
          );
        });
  }
}
