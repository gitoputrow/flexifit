// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    int? comment;
    String? photoProfile;
    List<String>? targetMuscle;
    String? age;
    String? id;
    List<String>? keywords;
    List<RecordChallengeDatum>? recordChallengeData;
    int? like;
    String? goal;
    String? name;
    String? height;
    int? post;
    String? email;
    String? gender;
    String? physical;
    String? username;
    String? weight;

    UserData({
        this.comment,
        this.photoProfile,
        this.targetMuscle,
        this.age,
        this.id,
        this.keywords,
        this.recordChallengeData,
        this.like,
        this.goal,
        this.name,
        this.height,
        this.post,
        this.email,
        this.gender,
        this.physical,
        this.username,
        this.weight,
    });

    UserData copyWith({
        int? comment,
        String? photoProfile,
        List<String>? targetMuscle,
        String? age,
        String? id,
        List<String>? keywords,
        List<RecordChallengeDatum>? recordChallengeData,
        int? like,
        String? goal,
        String? name,
        String? height,
        int? post,
        String? email,
        String? gender,
        String? physical,
        String? username,
        String? weight,
    }) => 
        UserData(
            comment: comment ?? this.comment,
            photoProfile: photoProfile ?? this.photoProfile,
            targetMuscle: targetMuscle ?? this.targetMuscle,
            age: age ?? this.age,
            id: id ?? this.id,
            keywords: keywords ?? this.keywords,
            recordChallengeData: recordChallengeData ?? this.recordChallengeData,
            like: like ?? this.like,
            goal: goal ?? this.goal,
            name: name ?? this.name,
            height: height ?? this.height,
            post: post ?? this.post,
            email: email ?? this.email,
            gender: gender ?? this.gender,
            physical: physical ?? this.physical,
            username: username ?? this.username,
            weight: weight ?? this.weight,
        );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        comment: json["comment"],
        photoProfile: json["photo_profile"],
        targetMuscle: json["target_muscle"] == null ? [] : List<String>.from(json["target_muscle"]!.map((x) => x["muscle"])),
        age: json["age"],
        id: json["id"],
        keywords: json["keywords"] == null ? [] : List<String>.from(json["keywords"]!.map((x) => x)),
        recordChallengeData: json["record_challenge_data"] == null ? [] : List<RecordChallengeDatum>.from(json["record_challenge_data"]!.map((x) => RecordChallengeDatum.fromJson(x))),
        like: json["like"],
        goal: json["goal"],
        name: json["name"],
        height: json["height"],
        post: json["post"],
        email: json["email"],
        gender: json["gender"],
        physical: json["physical"],
        username: json["username"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "photo_profile": photoProfile,
        "age": age,
        "id": id,
        "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
        "record_challenge_data": recordChallengeData == null ? [] : List<dynamic>.from(recordChallengeData!.map((x) => x.toJson())),
        "like": like,
        "goal": goal,
        "name": name,
        "height": height,
        "post": post,
        "email": email,
        "gender": gender,
        "physical": physical,
        "username": username,
        "weight": weight,
    };
}

class RecordChallengeDatum {
    String? title;
    Level? level;
    String? id;
    String? url;

    RecordChallengeDatum({
        this.title,
        this.level,
        this.id,
        this.url,
    });

    RecordChallengeDatum copyWith({
        String? title,
        Level? level,
        String? id,
        String? url,
    }) => 
        RecordChallengeDatum(
            title: title ?? this.title,
            level: level ?? this.level,
            id: id ?? this.id,
            url: url ?? this.url,
        );

    factory RecordChallengeDatum.fromJson(Map<String, dynamic> json) => RecordChallengeDatum(
        title: json["title"],
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
        id: json["id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "level": level?.toJson(),
        "id": id,
        "url": url,
    };
}

class Level {
    int? beginner;
    int? intermediate;

    Level({
        this.beginner,
        this.intermediate,
    });

    Level copyWith({
        int? beginner,
        int? intermediate,
    }) => 
        Level(
            beginner: beginner ?? this.beginner,
            intermediate: intermediate ?? this.intermediate,
        );

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        beginner: json["beginner"],
        intermediate: json["intermediate"],
    );

    Map<String, dynamic> toJson() => {
        "beginner": beginner,
        "intermediate": intermediate,
    };
}

class TargetMuscle {
    String? muscle;

    TargetMuscle({
        this.muscle,
    });

    TargetMuscle copyWith({
        String? muscle,
    }) => 
        TargetMuscle(
            muscle: muscle ?? this.muscle,
        );

    factory TargetMuscle.fromJson(Map<String, dynamic> json) => TargetMuscle(
        muscle: json["muscle"],
    );

    Map<String, dynamic> toJson() => {
        "muscle": muscle,
    };
}
