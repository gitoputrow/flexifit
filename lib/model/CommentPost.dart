// To parse this JSON data, do
//
//     final commentPost = commentPostFromJson(jsonString);

import 'dart:convert';

CommentPost commentPostFromJson(String str) => CommentPost.fromJson(json.decode(str));

String commentPostToJson(CommentPost data) => json.encode(data.toJson());

class CommentPost {
    String? idUser;
    String? idPost;
    String? id;
    String? username;
    String? profilePic;
    String? comment;
    DateTime? date;

    CommentPost({
        this.idUser,
        this.idPost,
        this.id,
        this.username,
        this.profilePic,
        this.comment,
        this.date,
    });

    CommentPost copyWith({
        String? idUser,
        String? idPost,
        String? id,
        String? username,
        String? profilePic,
        String? comment,
        DateTime? date,
    }) => 
        CommentPost(
            idUser: idUser ?? this.idUser,
            idPost: idPost ?? this.idPost,
            id: id ?? this.id,
            username: username ?? this.username,
            profilePic: profilePic ?? this.profilePic,
            comment: comment ?? this.comment,
            date: date ?? this.date,
        );

    factory CommentPost.fromJson(Map<String, dynamic> json) => CommentPost(
        idUser: json["idUser"],
        idPost: json["idPost"],
        id: json["id"],
        username: json["username"],
        profilePic: json["profilePic"],
        comment: json["comment"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "idPost": idPost,
        "id": id,
        "username": username,
        "profilePic": profilePic,
        "comment": comment,
        "date": date?.toIso8601String(),
    };
}
