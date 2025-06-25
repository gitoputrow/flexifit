import 'dart:convert';

import '../../../model/MediaModel.dart';

ReportPlaceModel bodyInformationFromJson(String str) =>
    ReportPlaceModel.fromJson(json.decode(str));

// String bodyInformationToJson(ReportPlaceModel data) =>
//     json.encode(data.toJson());

class ReportPlaceModel {
  String? desc;
  String? id;
  String? placeId;
  String? userNickName;
  String? userId;
  String? profilepicture;
  String? username;
  List<MediaModel>? media;
  String? photo;
  DateTime? date;
  bool canDelete;

  ReportPlaceModel(
      {this.id,
      this.placeId,
      this.desc,
      this.userId,
      this.photo,
      this.date,
      this.media,
      this.profilepicture,
      this.userNickName,
      this.canDelete = false,
      this.username});

  ReportPlaceModel copyWith(
          {String? desc,
          String? id,
          String? placeId,
          String? userId,
          String? photo,
          String? username,
          String? userNickName,
          List<MediaModel>? media,
          bool? canDelete,
          String? profilepicture,
          DateTime? date}) =>
      ReportPlaceModel(
          desc: desc ?? this.desc,
          id: id ?? this.id,
          photo: photo ?? this.photo,
          media: media ?? this.media,
          userNickName: userNickName ?? this.userNickName,
          placeId: placeId ?? this.placeId,
          userId: userId ?? this.userId,
          username: username ?? this.username,
          profilepicture: profilepicture ?? this.profilepicture,
          canDelete: canDelete ?? this.canDelete,
          date: date ?? this.date);

  factory ReportPlaceModel.fromJson(Map<String, dynamic> json) =>
      ReportPlaceModel(
        userId: json["user_id"],
        desc: json['desc'],
        id: json['id'],
        photo: json['photo'],
        media: json['media'] == null
            ? []
            : List<MediaModel>.from(
                json["media"].map((x) => MediaModel.fromJson(x))),
        placeId: json['place_id'],
        date: json['date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "desc": desc,
        "id": id,
        "photo": photo,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "place_id": placeId,
        "date": date?.toIso8601String(),
      };
}
