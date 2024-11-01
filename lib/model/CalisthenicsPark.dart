import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import GeoPoint

CalisthenicsPark calisthenicsParkFromJson(String str) =>
    CalisthenicsPark.fromJson(json.decode(str));

String calisthenicsParkToJson(CalisthenicsPark data) =>
    json.encode(data.toJson());

class CalisthenicsPark {
  String? displayAddress;
  String? id;
  double? distance;
  String? fullAddress;
  double? latitude;
  String? linkMaps;
  double? longitude;
  String? name;
  String? picture;
  List<Tool>? tools;
  String? category;
  Location? location; // New field for location (contains geohash and geopoint)

  CalisthenicsPark({
    this.displayAddress,
    this.distance,
    this.fullAddress,
    this.latitude,
    this.linkMaps,
    this.longitude,
    this.name,
    this.id,
    this.picture,
    this.tools,
    this.category, // New field for category
    this.location, // New field for location
  });

  CalisthenicsPark copyWith({
    String? displayAddress,
    double? distance,
    String? fullAddress,
    double? latitude,
    String? linkMaps,
    double? longitude,
    String? name,
    String? picture,
    List<Tool>? tools,
    String? id,
    String? category,
    Location? location,
  }) =>
      CalisthenicsPark(
        displayAddress: displayAddress ?? this.displayAddress,
        distance: distance ?? this.distance,
        fullAddress: fullAddress ?? this.fullAddress,
        latitude: latitude ?? this.latitude,
        linkMaps: linkMaps ?? this.linkMaps,
        longitude: longitude ?? this.longitude,
        name: name ?? this.name,
        picture: picture ?? this.picture,
        tools: tools ?? this.tools,
        category: category ?? this.category,
        location: location ?? this.location,
        id: id ?? this.id,
      );

  factory CalisthenicsPark.fromJson(Map<String, dynamic> json) {
    return CalisthenicsPark(
      displayAddress: json["display_address"],
      distance: json["distance"]?.toDouble(),
      fullAddress: json["full_address"],
      latitude: json["latitude"]?.toDouble(),
      linkMaps: json["link_maps"],
      longitude: json["longitude"]?.toDouble(),
      name: json["name"],
      picture: json["picture"],
      id: json['id'],
      category: json["category"], // Handling new field "category"
      location: json["location"] != null
          ? Location.fromJson(json["location"])
          : null, // Handling the "location" object
      tools: json["tools"] == null
          ? []
          : List<Tool>.from(json["tools"]!.map((x) => Tool.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "display_address": displayAddress,
        "distance": distance,
        "full_address": fullAddress,
        "latitude": latitude,
        "link_maps": linkMaps,
        "longitude": longitude,
        "name": name,
        "picture": picture,
        "category": category,
        "location": location?.toJson(), // Convert location to JSON
        "tools": tools == null
            ? []
            : List<dynamic>.from(tools!.map((x) => x.toJson())),
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

class Location {
  String? geohash;
  GeoPoint? geopoint; // GeoPoint from Firestore

  Location({
    this.geohash,
    this.geopoint,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        geohash: json["geohash"],
        geopoint: json["geopoint"], // GeoPoint will be directly handled
      );

  Map<String, dynamic> toJson() => {
        "geohash": geohash,
        "geopoint": geopoint, // No need to further serialize GeoPoint
      };
}
