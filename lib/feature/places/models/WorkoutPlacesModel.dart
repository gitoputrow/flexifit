import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'CityModel.dart';

WorkoutPlacesModel calisthenicsParkFromJson(String str) =>
    WorkoutPlacesModel.fromJson(json.decode(str));

String calisthenicsParkToJson(WorkoutPlacesModel data) =>
    json.encode(data.toJson());

class WorkoutPlacesModel {
  double? distance;
  String? linkMaps;
  String? displayAddress;
  double? latitude;
  String? fullAddress;
  List<Tool>? tools;
  // GeoPoint? location;
  String? picture;
  CityModel? city;
  String? name;
  String? id;
  int? reportCount;
  String? category;
  double? longitude;

  WorkoutPlacesModel({
    this.distance,
    this.linkMaps,
    this.displayAddress,
    // this.location,
    this.latitude,
    this.fullAddress,
    this.tools,
    this.picture,
    this.city,
    this.reportCount,
    this.name,
    this.id,
    this.category,
    this.longitude,
  });

  WorkoutPlacesModel copyWith({
    double? distance,
    String? linkMaps,
    // GeoPoint? location,
    String? displayAddress,
    double? latitude,
    String? fullAddress,
    List<Tool>? tools,
    String? picture,
    CityModel? province,
    String? name,
    String? id,
    int? reportCount,
    String? category,
    double? longitude,
  }) =>
      WorkoutPlacesModel(
        distance: distance ?? this.distance,
        linkMaps: linkMaps ?? this.linkMaps,
        // location: location ?? this.location,
        displayAddress: displayAddress ?? this.displayAddress,
        latitude: latitude ?? this.latitude,
        fullAddress: fullAddress ?? this.fullAddress,
        tools: tools ?? this.tools,
        picture: picture ?? this.picture,
        city: province ?? this.city,
        name: name ?? this.name,
        id: id ?? this.id,
        reportCount: reportCount ?? this.reportCount,
        category: category ?? this.category,
        longitude: longitude ?? this.longitude,
      );

  factory WorkoutPlacesModel.fromJson(Map<String, dynamic> json) =>
      WorkoutPlacesModel(
        distance: json["distance"]?.toDouble(),
        linkMaps: json["link_maps"],
        displayAddress: json["display_address"],
        latitude: json["latitude"]?.toDouble(),
        fullAddress: json["full_address"],
        tools: json["tools"] == null
            ? []
            : List<Tool>.from(json["tools"]!.map((x) => Tool.fromJson(x))),
        picture: json["picture"],
        city: json["province"] == null
            ? null
            : CityModel.fromJson(json["city"]),
        name: json["name"],
        id: json["id"],
        category: json["category"],
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "link_maps": linkMaps,
        "display_address": displayAddress,
        "latitude": latitude,
        "full_address": fullAddress,
        "tools": tools == null
            ? []
            : List<dynamic>.from(tools!.map((x) => x.toJson())),
        "picture": picture,
        "province": city?.toJson(),
        "name": name,
        "id": id,
        "category": category,
        "longitude": longitude,
      };
}

class Tool {
  String? name;
  String? picture;

  Tool({
    this.name,
    this.picture,
  });

  Tool copyWith({
    String? name,
    String? picture,
  }) =>
      Tool(
        name: name ?? this.name,
        picture: picture ?? this.picture,
      );

  factory Tool.fromJson(Map<String, dynamic> json) => Tool(
        name: json["name"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture,
      };
}
