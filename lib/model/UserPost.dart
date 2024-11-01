// To parse this JSON data, do
//
//     final userPost = userPostFromJson(jsonString);

import 'dart:convert';

UserPost userPostFromJson(String str) => UserPost.fromJson(json.decode(str));

String userPostToJson(UserPost data) => json.encode(data.toJson());

class UserPost {
  String? caption;
  int? comment;
  DateTime? date;
  int? dislike;
  String? id;
  String? imageSource;
  String? idUser;
  int? like;
  bool? liked;
  String? profilepicture;
  String? username;

  UserPost({
    this.caption,
    this.comment,
    this.date,
    this.dislike,
    this.id,
    this.imageSource,
    this.like,
    this.idUser,
    this.liked = false,
    this.profilepicture,
    this.username,
  });

  UserPost copyWith({
    String? caption,
    int? comment,
    DateTime? date,
    int? dislike,
    String? id,
    String? idUser,
    String? imageSource,
    int? like,
    bool? liked,
    String? profilepicture,
    String? username,
  }) =>
      UserPost(
        caption: caption ?? this.caption,
        comment: comment ?? this.comment,
        date: date ?? this.date,
        dislike: dislike ?? this.dislike,
        id: id ?? this.id,
        idUser: idUser ?? this.idUser,
        imageSource: imageSource ?? this.imageSource,
        like: like ?? this.like,
        liked: liked ?? this.liked,
        profilepicture: profilepicture ?? this.profilepicture,
        username: username ?? this.username,
      );

  factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
        caption: json["caption"],
        comment: json["comment"],
        date: DateTime.parse(json["date"]),
        dislike: json["dislike"],
        id: json["id"],
        imageSource: json["imageSource"],
        like: json["like"],
        idUser: json["idUser"],
        // liked: json["liked"],
        profilepicture: json["profilepicture"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "comment": comment,
        "date": date,
        "dislike": dislike,
        "id": id,
        "imageSource": imageSource,
        "like": like,
        "liked": liked,
        "profilepicture": profilepicture,
        "username": username,
      };
}
