// To parse this JSON data, do
//
//     final challengeModel = challengeModelFromJson(jsonString);

import 'dart:convert';

import 'package:pain/feature/workout/models/WorkoutData.dart';

ChallengeModel challengeModelFromJson(String str) =>
    ChallengeModel.fromJson(json.decode(str));

String challengeModelToJson(ChallengeModel data) => json.encode(data.toJson());

class ChallengeModel {
  List<Level>? level;
  String? picture;
  String? title;
  String? id;

  ChallengeModel({
    this.level,
    this.picture,
    this.title,
    this.id,
  });

  ChallengeModel copyWith({
    List<Level>? level,
    String? picture,
    String? title,
    String? id,
  }) =>
      ChallengeModel(
        level: level ?? this.level,
        picture: picture ?? this.picture,
        title: title ?? this.title,
        id: id ?? this.id,
      );

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => ChallengeModel(
        level: json["Level"] == null
            ? []
            : List<Level>.from(json["Level"]!.map((x) => Level.fromJson(x))),
        picture: json["picture"],
        title: json["title"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "Level": level == null
            ? []
            : List<dynamic>.from(level!.map((x) => x.toJson())),
        "picture": picture,
        "title": title,
        "id": id,
      };
}

class Level {
  String? desc;
  String? picture;
  String? title;
  String? total;
  WorkoutData? workoutData;

  Level({
    this.desc,
    this.picture,
    this.title,
    this.workoutData,
    this.total,
  });

  Level copyWith({
    String? desc,
    String? picture,
    String? title,
    WorkoutData? workoutData,
    String? total,
  }) =>
      Level(
        desc: desc ?? this.desc,
        picture: picture ?? this.picture,
        title: title ?? this.title,
        total: total ?? this.total,
        workoutData: workoutData ?? this.workoutData,
      );

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        desc: json["desc"],
        picture: json["picture"],
        title: json["title"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "picture": picture,
        "title": title,
        "total": total,
      };
}
