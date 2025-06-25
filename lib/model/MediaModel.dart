import 'package:pain/widget/MediaWidget.dart';

class MediaModel {
  String? idPic;
  String? path;
  String? thumbnail;
  String? thumbnailFile;
  String? filePath;
  MediaType? type;

  MediaModel(
      {this.idPic,
      this.path,
      this.type,
      this.thumbnail,
      this.thumbnailFile,
      this.filePath});

  MediaModel copyWith(
          {String? idPic,
          String? path,
          MediaType? type,
          String? thumbnail,
          String? thumbnailFile,
          String? filePath}) =>
      MediaModel(
          idPic: idPic ?? this.idPic,
          path: path ?? this.path,
          filePath: filePath ?? this.filePath,
          thumbnailFile: thumbnailFile ?? this.thumbnailFile,
          thumbnail: thumbnail ?? this.thumbnail,
          type: type ?? this.type);

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        idPic: json["id_pic"],
        path: json["path"],
        thumbnail: json["thumbnail"],
        type: MediaType.values.byName(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id_pic": idPic,
        "path": path,
        "thumbnail": thumbnail,
        "type": type.toString(),
      };
}
